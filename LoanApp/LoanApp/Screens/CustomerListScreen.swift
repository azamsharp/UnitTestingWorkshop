//
//  CustomerListScreen.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/27/24.
//

import SwiftUI

struct Customer: Identifiable {
    let id = UUID()
    let name: String
}

enum SortDirection: Identifiable {
    case asc
    case desc
    case none
    
    var id: Int {
        switch self {
            case .asc: return 0
            case .desc: return 1
            case .none: return 2
        }
    }
}

struct SortAction {
    typealias Action = ([Customer], SortDirection) -> ([Customer])
    let action: Action
    func callAsFunction(_ customers: [Customer], _ sortDirection: SortDirection) -> [Customer] {
        return action(customers, sortDirection)
    }
}

struct SortEnvironmentKey: EnvironmentKey {
    static var defaultValue: SortAction = SortAction { _, _ in
        return []
    }
}

extension EnvironmentValues {
    var sort: (SortAction) {
        get { self[SortEnvironmentKey.self] }
        set { self[SortEnvironmentKey.self] = newValue }
    }
}

struct CustomerListState {
    
    func sortCustomers(_ customers: [Customer], _ sortDirection: SortDirection) -> [Customer] {
        switch sortDirection {
            case .asc:
                return customers.sorted { $0.name < $1.name }
            case .desc:
                return customers.sorted { $0.name > $1.name }
            case .none:
                return customers
        }
    }
    
}

struct CustomerListScreen: View {
    
    // custom environment value
    @Environment(\.sort) private var sort
    
    @State private var customers = [
        Customer(name: "Alice"),
        Customer(name: "Bob"),
        Customer(name: "Charlie"),
        Customer(name: "David"),
        Customer(name: "Eve"),
        Customer(name: "Frank"),
        Customer(name: "Grace"),
        Customer(name: "Hannah"),
        Customer(name: "Ivy"),
        Customer(name: "Jack")
    ]
    
    @State private var sortDirection: SortDirection = .none
   
    var body: some View {
        VStack {
            
            HStack {
                
                Button("Sort ASC") {
                    customers = sort(customers, SortDirection.asc)
                }
                Spacer()
                Button("Sort DESC") {
                    customers = sort(customers, SortDirection.desc)
                }
            }.padding()
            
            List {
                
                ForEach(customers) { customer in
                    Text(customer.name)
                }
            }
        }
    }
}

#Preview {
    CustomerListScreen()
        .environment(\.sort, SortAction(action: { customers, sortDirection in
            switch sortDirection {
                case .asc:
                    return customers.sorted { $0.name < $1.name }
                case .desc:
                    return customers.sorted { $0.name > $1.name }
                case .none:
                    return customers
            }
        }))
}
