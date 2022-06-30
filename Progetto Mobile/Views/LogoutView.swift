//
//  LogoutView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 22/05/22.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject private var opdata: OpDat
    var body: some View {
        VStack (spacing: 20){
            Text("Vuoi veramente uscire?")
                .foregroundColor(Color("AccentColor"))
                .font(.title3)
            Text("Clicca sul bottone in basso.")
                .font(.body)
            
            Button{
                let result = KeychainStorage.removeCredentials()
                if result{
                    opdata.currView = .welcome
                }
            } label: {
                Text("Logout")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Spacer()
        }
        .padding()
        
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
