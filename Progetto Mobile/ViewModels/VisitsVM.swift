//
//  NotificationVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 16/05/22.
//

import Foundation
import GRDB
import EventKit

class visitVM: DataWrapper, ObservableObject {
 
    @Published var listVisits: [Visit] = []
    @Published var status: String = ""
    
    let appleEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    
    func getAllVisitByUserID(){
        let userID = KeychainStorage.getCredentials()!.id
        print(userID)
        do {
            try getDatabase().write{ db in
                //.filter(Column("userID") == KeychainStorage.getCredentials()!.id)
                listVisits = try Visit.order(Column("date").desc).fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func addVisit(day: Date) -> Bool{
        let userID = KeychainStorage.getCredentials()!.id
        var found: Bool = false
        do {
            try getDatabase().write { db in
                _ = try Visit(date: day, userID: userID).insert(db)
                found = true
            }
        } catch{
            print(error)
        }
        return found
    }
    
    func getVisitByID(id: String) -> Visit? {
        var visit: Visit? = nil
        do {
            try getDatabase().write { db in
                visit = try Visit.filter(id: id).fetchOne(db)
            }
        } catch{
            print(error)
        }
        return visit
    }
    
    func generateEvent(id: String) {
        switch  EKEventStore.authorizationStatus(for: .event){
            case .notDetermined:
                // This happens on first-run
                requestAccessToCalendar(id: id)
            case .authorized:
                // User has access
                print("User has access to calendar")
            self.addAppleEvents(id: id)
            case .restricted, .denied:
                // We need to help them give us permission
                noPermission()
            @unknown default:
                print("Case default")
        }
    }
    
    func noPermission()
    {
        print("User has to change settings...goto settings to view access")
    }
    
    func requestAccessToCalendar(id: String) {
        appleEventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                DispatchQueue.main.async {
                    print("User has access to calendar")
                    self.addAppleEvents(id: id)
                }
            } else {
                DispatchQueue.main.async{
                    self.noPermission()
                }
            }
        })
    }
    
    func addAppleEvents(id: String)
    {
        let visit = self.getVisitByID(id: id)
        let calendar = Calendar.current
        let enddate = calendar.date(byAdding: .hour, value: 1, to: visit!.date)
        
        let event:EKEvent = EKEvent(eventStore: appleEventStore)
        event.title = "Controllo Periodico"
        event.startDate = visit?.date
        event.endDate = enddate
        event.notes = "Appuntamento generato dall'app."
        event.calendar = appleEventStore.defaultCalendarForNewEvents

        do {
            try appleEventStore.save(event, span: .thisEvent)
            print("events added with dates:")
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
    }
    
}
