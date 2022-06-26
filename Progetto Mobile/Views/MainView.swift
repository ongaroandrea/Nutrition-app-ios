//
//  MainView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 19/05/22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var opData: OpDat
    @EnvironmentObject var delegate: AppDelegate
    @EnvironmentObject var auth: AuthenticationManager
    var body: some View {
        if delegate.openedFromNotification {
            CreateSensationView()
                .environmentObject(opData)
                .environmentObject(delegate)
                .environmentObject(auth)
        } else {
            switch(opData.currView){
                    case .welcome:
                        WelcomeView()
                            .environmentObject(opData)
                            .environmentObject(delegate)
                            .environmentObject(auth)
                    case .signin:
                        SigninView()
                            .environmentObject(opData)
                            .environmentObject(delegate)
                            .environmentObject(auth)
                    case .signup:
                        LoginView()
                            .environmentObject(opData)
                            .environmentObject(delegate)
                            .environmentObject(auth)
                    case .home:
                        TabViewMenuView()
                            .environmentObject(opData)
                            .environmentObject(delegate)
                            .environmentObject(auth)
                    case .authentication:
                        AuthenticationView()
                            .environmentObject(opData)
                            .environmentObject(delegate)
                            .environmentObject(auth)
                
                    case .sensation:
                        ListSensationView()
                            .environmentObject(opData)
                            .environmentObject(delegate)
                            .environmentObject(auth)
            }
        }
        
    }
    
}
