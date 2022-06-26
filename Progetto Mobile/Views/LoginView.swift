//
//  Login.swift
//  test
//
//  Created by Andrea  Ongaro on 25/03/22.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var opData: OpDat
    @StateObject private var viewModel = UserVM()
    @State private var mail: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack (spacing: 50) {
            Spacer()
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Primary"))
            
            Image("logo_blu")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 150)
            Spacer()
            VStack (spacing:25) {
                HStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("AccentColor"))
                    TextField("username", text: $mail)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                    
                HStack{
                    Image(systemName: "key.fill")
                        .foregroundColor(Color("AccentColor"))
                    SecureField("password", text: $password)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            }
            .padding(.horizontal, 60)
            
            Button("Login") {
                print("Login")
                print(mail)
                print(password)
                let result = viewModel.loginUser(mail: mail, password: password)
                if(!result){
                    print("Loggato Correttamente")
                    opData.currView = CurrView.home
                } else {
                    print("NON")
                }
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("Grigio_chiaro"))
            .cornerRadius(roundedCornes)
            .padding(3)
            .font(.custom("Open Sans", size: 18))
            .foregroundColor(.blue)
            .opacity(0.35)
            .shadow(radius: 20)
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}
