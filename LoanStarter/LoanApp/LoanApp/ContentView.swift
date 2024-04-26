//
//  ContentView.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var ssn: String = ""
    let aprService: APRService
    
    @State private var apr: Double?

    var body: some View {
        VStack {
            TextField("Enter SSN", text: $ssn)
                .textFieldStyle(.roundedBorder)
                
            Button("Submit") {
                Task {
                    do {
                        apr = try await aprService.calculateAPR(ssn: ssn)
                    } catch {
                        print(error)
                    }
                }
                
            }
            
            if let apr {
                Text(String(format: "%.3f", apr))
                   
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Calculate APR")
    }
}


#Preview {
    NavigationStack {
        // But MockedHTTPClient is in the testing target
        ContentView(aprService: APRService(creditScoreService: MockedCreditScoreService()))
    }
}
