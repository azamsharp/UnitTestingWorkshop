//
//  ContentView.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name: String = ""
    @State private var ssn: String = ""
    @State private var loanAmount: Double = 0.0 
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .navigationTitle("Apply for Loan")
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
