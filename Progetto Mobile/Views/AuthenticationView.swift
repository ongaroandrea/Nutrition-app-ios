//
//  AuthenticationView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 30/05/22.
//

import SwiftUI

struct AuthenticationView: View {
    let loginFace : LocalizedStringKey = "loginFace"
    let loginTouch : LocalizedStringKey = "loginTouch"
    let loginCredential : LocalizedStringKey = "loginCredential"
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var opDat: OpDat
        var body: some View {
            NavigationView{
                VStack(spacing: 40) {
                    Spacer()
                    // Evaluate the biometryType and display a button accordingly
                    switch authenticationManager.biometryType {
                    case .faceID:
                        PrimaryButton(image: "faceid", text: loginFace.stringValue())
                            .onTapGesture {
                                Task.init {
                                    await authenticationManager.authenticateWithBiometrics()
                                    if authenticationManager.isAuthenticated {
                                        opDat.currView = .home
                                    } else {
                                        
                                    }
                                        
                                }
                            }
                    case .touchID:
                        PrimaryButton(image: "touchid", text: loginTouch.stringValue())
                            .onTapGesture {
                                Task.init {
                                    await authenticationManager.authenticateWithBiometrics()
                                    if authenticationManager.isAuthenticated {
                                        opDat.currView = .home
                                    } else {
                                        
                                    }
                                }
                            }
                    default:
                        NavigationLink {
                            LoginView()
                                .environmentObject(authenticationManager)
                        } label: {
                            PrimaryButton(image: "person.fill", text: loginCredential.stringValue())
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(colors: [.blue, Color("AccentColor")], startPoint: .topLeading, endPoint: .bottomTrailing))
            }.onAppear(perform: {
                authenticationManager.getBiometryType()
            })
        }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(AuthenticationManager())
            .environmentObject(OpDat())
    }
}

struct PrimaryButton: View {
    var image: String?
    var showImage = true
    var text: String
    
    var body: some View {
        HStack {
            if showImage {
                Image(systemName: image ?? "person.fill")
                    .foregroundColor(.teal)
            }
            
            Text(text)
                .foregroundColor(.teal)
        }
        .padding()
        .padding(.horizontal)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}
