//
//  Notification.swift
//  test
//
//  Created by Andrea  Ongaro on 03/04/22.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    
    var body: some View {
            List {
                ForEach(notificationManager.notifications, id: \.identifier) { notification in
                    HStack {
                        Text(notification.content.title)
                            .fontWeight(.semibold)
                        /*Text(timeDisplayText(from: notification))
                            .fontWeight(.bold)*/
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(InsetGroupedListStyle())
            .overlay(
                VStack {
                Text("df")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                Button {
                    isCreatePresented = true
                } label: {
                    Label("buttonTitle", systemImage: "plus")
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(5)
            }
            .padding())
            .navigationTitle("Notifications")
            .onAppear(perform: notificationManager.reloadAuthorizationStatus)
            .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
                switch authorizationStatus {
                case .notDetermined:
                    notificationManager.requestAuthorization()
                case .denied:
                    notificationManager.reloadLocalNotifications()
                default:
                    EmptyView()
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
                        isPresented: $isCreatePresented
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
