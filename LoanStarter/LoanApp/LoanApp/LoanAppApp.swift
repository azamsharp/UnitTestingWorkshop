//
//  LoanAppApp.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/19/24.
//

import SwiftUI



@main
struct LoanAppApp: App {
    
    let aprService: APRService
    
    init() {
        
        // If running in DEV mode then set the URL to the development service
        var baseURL = URL(string: "https://island-bramble.glitch.me")!
        
        // if running in prod mode then set the URL to prod. Check the build settings
        
        // if running in test mode then set the url to test
        
        if ProcessInfo.processInfo.arguments.contains("UITEST") {
            // Set the contained TEST URL
            baseURL = URL(string: "staging.island-bramble.glitch.me")!
        }
        
        let creditScoreService = CreditScoreService(baseURL: baseURL)
        aprService = APRService(creditScoreService: creditScoreService) 
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(aprService: aprService)
        }
    }
}
