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
        Button("Non fare che non ci vediamo più eh") {
            let result = KeychainStorage.removeCredentials()
            if result{
                opdata.currView = .welcome
            }
            
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
