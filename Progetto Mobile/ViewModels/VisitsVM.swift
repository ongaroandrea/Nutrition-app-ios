//
//  NotificationVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 16/05/22.
//

import Foundation
import GRDB
import EventKit
import SwiftUI

class visitVM: DataWrapper, ObservableObject {
 
    @Published var listVisits: [Visit] = []
    @Published var status: Bool = false
    
    let appleEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    
    func getAllVisitByUserID(){
        if KeychainStorage.getCredentials() != nil {
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
        
    }
    
    func checkVisit(day: Date) -> Bool {
        var visit: Visit? = nil
        var lists: [Visit] = []
        do {
            try getDatabase().write { db in
                //visit = try Visit.filter(Column("date") == day).fetchOne(db)
                lists = try Visit.fetchAll(db)
            }
        } catch{
            print(error)
        }
        for visit in lists {
            if isSameDay(date1: visit.date, date2: day){
                return true
            }
        }

        return false
    }

    func addVisit(day: Date) -> Bool{
        let userID = KeychainStorage.getCredentials()!.id
        let found: Bool = checkVisit(day: day)
        if(!found){
            do {
                try getDatabase().write { db in
                    _ = try Visit(date: day, userID: userID).insert(db)
                }
            } catch{
                print(error)
            }
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
        self.status = false
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
            self.status = true
        } catch let e as NSError {
            print(e.description)
            self.status = false
        }
        print("Saved Event")
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
}
