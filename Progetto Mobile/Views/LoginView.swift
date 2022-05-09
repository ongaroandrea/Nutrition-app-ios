//
//  Login.swift
//  test
//
//  Created by Andrea  Ongaro on 25/03/22.
//

import SwiftUI

struct LoginView: View {

    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack (spacing: 100) {
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("light_blue"))
            
            Image("logo_blu")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 150)
            VStack (spacing:25) {
                HStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("AccentColor"))
                    TextField("username", text: $username)
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
                    
                HStack{
                    Image(systemName: "key.fill")
                        .foregroundColor(Color("AccentColor"))
                    TextField("password", text: $password)
                        
                }
                .modifier(customViewModifier(roundedCornes: 20, textColor: .white))
            }
            .padding(.horizontal, 60)
            
            Button("Login") {
                print("Login")
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 15))

        }
    }
}

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.gray)
            .opacity(0.45)
            .cornerRadius(roundedCornes)
            .padding(3)
            .font(.custom("Open Sans", size: 18))
            .foregroundColor(.black)
            .shadow(radius: 20)
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
