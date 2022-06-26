//
//  FaceIDView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 20/05/22.
//

import SwiftUI

struct FaceIDView: View {
    @State var showGreeting = false
    @State var firstOpening = false
    @EnvironmentObject var authenticationManager: AuthenticationManager
    let titolo_1 : LocalizedStringKey = "biometrico_titolo"
    let biometrico_errore : LocalizedStringKey = "biometrico_errore"
    let biometrico_body : LocalizedStringKey = "biometrico_body"
    var impostazioni: LocalizedStringKey = "impostazioni"
    
    var body: some View {
        VStack {
            Text(titolo_1.stringValue())
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Primary"))
            
            if(!authenticationManager.canEvaluatePolicy){
                Text(biometrico_errore.stringValue())
            } else {
                Toggle(biometrico_body.stringValue(), isOn: $showGreeting).onChange(of: showGreeting) { value in
                    if value && self.firstOpening {
                        Task.init {
                            await authenticationManager.authenticateWithBiometrics()
                            if authenticationManager.isAuthenticated {
                                UserDefaults.standard.set(true, forKey: "lock")
                            } else {
                                showGreeting = false
                                UserDefaults.standard.set(false, forKey: "lock")
                            }
                            
                        }
                    } else {
                        print("ciao")
                        self.firstOpening = true
                        UserDefaults.standard.set(false, forKey: "lock")
                    }
                    
                    print(UserDefaults.standard.object(forKey: "lock") as? Bool ?? false)
                }
                .onAppear(perform: {
                    showGreeting = UserDefaults.standard.object(forKey: "lock") as? Bool ?? false
                })
                if showGreeting {
                    Text("Sblocco con FaceID attivo")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(impostazioni)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            authenticationManager.getBiometryType()
            self.firstOpening = true
            
            
        })
    }
}

struct FaceIDView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDView()
            .environmentObject(AuthenticationManager())
    }
}
