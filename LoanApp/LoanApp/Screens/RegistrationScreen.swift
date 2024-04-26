//
//  RegistrationScreen.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/26/24.
//

import SwiftUI

struct RegistrationForm {
    
    var firstName: String = ""
    var lastName: String = ""
    var ssn: String = ""
    
    var isValid: Bool {
        return !firstName.isEmptyOrWhiteSpace && !lastName.isEmptyOrWhiteSpace && ssn.isSSN
    }
    
}

struct RegistrationScreen: View {
    
    @State private var registrationForm = RegistrationForm()
    
    var body: some View {
        Form {
            TextField("First name", text: $registrationForm.firstName)
            TextField("Last name", text: $registrationForm.lastName)
            TextField("SSN", text: $registrationForm.ssn)
            
            Button("Submit") {
                
            }.disabled(!registrationForm.isValid)
        }
    }
}

#Preview {
    RegistrationScreen()
}
