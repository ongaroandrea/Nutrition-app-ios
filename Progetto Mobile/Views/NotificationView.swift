//
//  Notification.swift
//  test
//
//  Created by Andrea  Ongaro on 03/04/22.
//

import SwiftUI

struct NotificationView: View {
    
    @StateObject var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    @State private var error = false
    
    let nessuna_notifica : LocalizedStringKey = "nessuna_notifica"
    let no_permessi : LocalizedStringKey = "no_permessi"
    let impostazioni : LocalizedStringKey = "impostazioni"
    let crea : LocalizedStringKey = "crea"
    let notifiche : LocalizedStringKey = "notifiche"
    
    static var notificationDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            return dateFormatter
    }()
        
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
            guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
            return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
        var infoOverlayView: some View {
            switch notificationManager.authorizationStatus {
            case .authorized:
                if notificationManager.notifications.isEmpty {
                    InfoOverlayView(
                        infoMessage: nessuna_notifica.stringValue(),
                        buttonTitle: crea.stringValue(),
                        systemImageName: "plus.circle.fill",
                        action: {
                            isCreatePresented = true
                        }
                    )
                }
            case .denied:
                InfoOverlayView(
                    infoMessage: no_permessi.stringValue(),
                    buttonTitle: impostazioni.stringValue(),
                    systemImageName: "gear",
                    action: {
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                )
            default:
                EmptyView()
            }
        }
        
        var body: some View {
            
            List {
                HStack{
                    Spacer()
                    Text(notifiche.stringValue())
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("AccentColor"))
                        
                    Spacer()
                }
                .listRowSeparator(.hidden)
                ForEach(notificationManager.notifications, id: \.identifier) { notification in
                    HStack {
                        Text(notification.content.title)
                            .fontWeight(.semibold)
                        Text(timeDisplayText(from: notification))
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(impostazioni.stringValue())
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .overlay(infoOverlayView)
            .onAppear(perform: notificationManager.reloadAuthorizationStatus)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear
            })
            
            .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
                switch authorizationStatus {
                case .notDetermined:
                    notificationManager.requestAuthorization()
                case .authorized:
                    notificationManager.reloadLocalNotifications()
                default:
                    break
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                notificationManager.reloadAuthorizationStatus()
            }
            .navigationBarItems(trailing: Button {
                isCreatePresented = true
            } label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            })
            .sheet(isPresented: $isCreatePresented) {
                NavigationView {
                    CreateNotificationView(
                        notificationManager: notificationManager,
                        isPresented: $isCreatePresented, error: $error
                    )
                }
                .accentColor(.primary)
            }
        }
    }


extension NotificationView {
    func delete(_ indexSet: IndexSet) {
            notificationManager.deleteLocalNotifications(
                identifiers: indexSet.map { notificationManager.notifications[$0].identifier }
            )
            notificationManager.reloadLocalNotifications()
        }
}

struct Notification_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
