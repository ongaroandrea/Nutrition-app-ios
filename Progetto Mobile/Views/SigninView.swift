//
//  CreateView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 17/05/22.
//

import SwiftUI

struct SigninView: View {
    
    @EnvironmentObject var opData: OpDat
    
    @StateObject private var viewModel = UserVM()
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var mail: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    let crea_account : LocalizedStringKey = "crea_account"
    let nome : LocalizedStringKey = "nome"
    let cognome : LocalizedStringKey = "cognome"
    let confirm_password : LocalizedStringKey = "confirm_password"
    var body: some View {
        VStack (spacing: 50) {
            Spacer()
            Text(crea_account)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Primary"))

            
            VStack (spacing:25) {
                
                Text("\(viewModel.status)")
                HStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("AccentColor"))
                    TextField(nome, text: $name)
                        .disableAutocorrection(true)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                
                HStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("AccentColor"))
                    TextField("cognome", text: $surname)
                        .disableAutocorrection(true)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                
                HStack{
                    Image(systemName: "mail.fill")
                        .foregroundColor(Color("AccentColor"))
                    TextField("mail", text: $mail)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                
                HStack{
                    Image(systemName: "key.fill")
                        .foregroundColor(Color("AccentColor"))
                    SecureField("password", text: $password)
                        .autocapitalization(.none)
                       
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                
                HStack{
                    Image(systemName: "key.fill")
                        .foregroundColor(Color("AccentColor"))
                    SecureField(confirm_password, text: $confirmPassword)
                        .autocapitalization(.none)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                
            }
            .padding(.horizontal, 60)
            
            Button("Login") {
                let response = viewModel.createUser(name: name, surname: surname, mail: mail, password: password, confirmPassword: confirmPassword)
                if(response){
                    opData.currView = CurrView.signup
                } else {
                    print("")
                }
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            Spacer()
        }
        .padding(.top, -100)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
