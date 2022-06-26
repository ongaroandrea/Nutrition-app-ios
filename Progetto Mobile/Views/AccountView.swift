//
//  AccountView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 20/05/22.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject private var viewModel: UserVM = UserVM()
    
    @State private var nome: String = ""
    @State private var cognome: String = ""
    @State private var mail: String = ""
    @State private var sport: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var showingAlertError = false
    private var error : LocalizedStringKey = "errore"
    private var successo : LocalizedStringKey = "successo"
    private var valori_non_modificati : LocalizedStringKey = "valori_non_modificati"
    private var valori_modificati : LocalizedStringKey = "valori_modificati"
    private var titolo_modifica_dati : LocalizedStringKey = "titolo_modifica_dati"
    private var impostazioni : LocalizedStringKey = "impostazioni"
    
    var body: some View {
        VStack{
            Text(titolo_modifica_dati.stringValue())
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Primary"))
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(Color("AccentColor"))
                TextField(viewModel.userLogged?.name ?? "", text: $nome)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(Color("AccentColor"))
                TextField(viewModel.userLogged?.surname ?? "", text: $cognome)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(Color("AccentColor"))
                TextField(viewModel.userLogged?.email ?? "", text: $mail)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(Color("AccentColor"))
                TextField(viewModel.userLogged?.sport ?? "", text: $sport)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(Color("AccentColor"))
                SecureField("password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            
            Button("Modifica") {
                print("Login")
                print(mail)
                print(password)
                
                let result = viewModel.updateUser(name: nome, surname: cognome, sport: sport, password: password, email: mail)
                if(!result){
                    print("Loggato Correttamente")
                    showingAlert = true
                    showingAlertError = false
                } else {
                    showingAlert = false
                    showingAlertError = true
                    print("NON")
                }
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .alert(isPresented: $showingAlertError) {
                Alert(title: Text(error.stringValue()), message: Text(valori_non_modificati.stringValue()), dismissButton: .default(Text("Ok!")))
            }
            Spacer()
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(successo.stringValue()), message: Text(valori_modificati.stringValue()), dismissButton: .default(Text("Ok!")))
        }
        .padding()
        .onAppear(perform: {
            viewModel.setCurrentUser()
            nome = viewModel.userLogged?.name ?? ""
            cognome = viewModel.userLogged?.surname ?? ""
            mail = viewModel.userLogged?.email ?? ""
            sport = viewModel.userLogged?.sport ?? ""
            password = viewModel.userLogged?.password ?? ""
            
        })
        .navigationTitle(impostazioni.stringValue())
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
