//
//  Progetto_MobileApp.swift
//  Progetto Mobile
//
//  Created by Andrea Ongaro on 02/05/22.
//

import SwiftUI

///https://www.hackingwithswift.com/forums/swiftui/pushing-a-view-without-navigation-view-swift-ui/6859
enum CurrView:Int {
    case welcome
    case signin
    case signup
    case home
    case authentication
    case sensation
}

class OpDat : ObservableObject {
    @Published var currView = CurrView.welcome
}

//https://stackoverflow.com/questions/65961637/swiftui-notification-click-go-to-a-specific-view

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published var openedFromNotification: Bool = false
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification received with identifier \(notification.request.identifier)")
        openedFromNotification = true
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        openedFromNotification = true
        completionHandler()
    }
}

@main
struct Progetto_MobileApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private var auth: AuthenticationManager = AuthenticationManager()
    private var opDat = OpDat()
    init(){
        let dw: DataWrapper = DataWrapper()
        dw.initialize()
        let value = UserDefaults.standard.object(forKey: "lock") as? Bool ?? false

        if value {
            opDat.currView = .authentication
        }
        if !value && KeychainStorage.getCredentials() != nil  {
            opDat.currView = .home
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(opDat)
                .environmentObject(appDelegate)
                .environmentObject(auth)
        }
    }
}
