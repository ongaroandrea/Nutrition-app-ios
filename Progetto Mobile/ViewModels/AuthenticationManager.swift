//
//  LoginVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 07/05/22.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var canEvaluatePolicy = false
    @Published private(set) var isAuthenticated = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    // On initialize of this class, get the biometryType
    init() {
        //getBiometryType()
    }
    
    func getBiometryType() {
        // canEvaluatePolicy will let us know if the user's device supports biometrics authentication
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
        // Getting the biometryType - in other words, if the device supports FaceID, TouchID, or doesn't support biometrics auth
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        // Resetting the LAContext so on the next login, biometrics are checked again
        context = LAContext()
        
        // Only evaluatePolicy if device supports biometrics auth
        if canEvaluatePolicy {
            let reason = "Log into your account"
            
            do {
                // evaluatePolicy will check if user is the device's owner, returns a boolean value that'll let us know if it successfully identified the user
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                
                // Only if it's a success, we'll set isAuthenticated to true
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        print("isAuthenticated", self.isAuthenticated)
                    }
                }
            } catch {
                print(error.localizedDescription)
                
                // If we run into an error, we'll set the errorDescription, we'll show an alert and set the biometryType to none, so user can login with credentials
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                }
            }
        }
    }
}
