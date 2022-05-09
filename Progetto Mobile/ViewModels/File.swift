//
//  File.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 06/04/22.
//

import Foundation
import GRDB

final class DataWrapper: ObservableObject{
    
    private var db: DatabaseQueue?;
    @Published var listUsers = [User]()
    @Published var listUsersInfo = [UserInfo]()
    
    init(){
        var config = Configuration()
        config.prepareDatabase { db in
            db.trace { print($0) }
        }
        
        var dbQueue: DatabaseQueue?;
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first ?? ""

            dbQueue = try DatabaseQueue(path: "\(path)/database.sqlite", configuration: config)
        } catch {
            print(error)
            dbQueue = nil
        }
        self.db = dbQueue
        createSubscritionTable()
        insertSubscription()
        //getAllSubscription()
        createUsersTable()
        insertUser()
        //print(getAllUsers())
        listUsers = getAllUsers()
        listUsersInfo = getOneUser()
        getUsersSubscdription()
    }
    
    func createUsersTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(User.databaseTableName)
                if(response){
                    try db.drop(table: User.databaseTableName)
                }
                try db.create(table: User.databaseTableName) { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("name", .text).notNull()
                    t.column("surname", .text).notNull()
                    t.column("email", .text).notNull()
                    t.column("password", .text).notNull()
                    t.column("dataNascita", .text).notNull()
                    t.column("subscriptionID", .integer)
                        .notNull()
                        .indexed()
                        .references("subscription", onDelete: .cascade)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func insertUser(){
        do {
            try self.db!.write { db in
                try User(id: 1, name: "Arthur", surname: "Loga", email: "andrea@yahho.it", password: "asdsdfsf", dataNascita: "26/02/2012", subscriptionID: 1).insert(db)
                try User(id: 2, name: "Marilosky", surname: "Loga", email: "andrea@yahho.it", password: "asdsdfsf", dataNascita: "26/02/2012", subscriptionID: 1).insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func getAllUsers() -> [User] {
        do {
            let listUser: [User] = try self.db!.read { db in
                try User.including(required: User.subscription)
                        .fetchAll(db)
            }
            return listUser
        } catch{
            return []
        }
    }
    
    func updateUser(id: Int64){
        do {
            try self.db!.write { db in
                if var user = try User.fetchOne(db, id: id) {
                    user.name = "Stuwart";
                    try user.update(db)
                }
            }
            listUsers = getAllUsers()
        } catch{
            print(error)
        }
    }
    
    func getOneUser() -> [UserInfo]{
        do {
            let listUsersInfo = try self.db!.read { db in
                try User.including(required: User.subscription).asRequest(of: UserInfo.self).fetchAll(db)
            }
            return listUsersInfo;
        } catch{
            print(error)
        }
        return []
    }
    
    func createSubscritionTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists("subscription")
                if(response){
                    print("eliminazione")
                    try db.drop(table: "subscription")
                }
                try db.create(table: "subscription") { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("name", .text).notNull()
                }
            }
        } catch {
            print(error)
        }
    }
    
    func insertSubscription(){
        do {
            try self.db!.write { db in
                try Subscription(id: 1, name: "Base").insert(db)
                try Subscription(id: 2, name: "Medio").insert(db)
                try Subscription(id: 3, name: "Completo").insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func getAllSubscription(){
        do {
            let listUser: [Subscription] = try self.db!.read { db in
                try Subscription.fetchAll(db)
            }
            print(listUser)
        } catch{
            print(error)
        }
    }
    
    func getUsersSubscdription(){
        do {
            let request = try self.db!.read { db in
                try Subscription
                    .including(required: Subscription.users)
                    .fetchAll(db)
            }
            print(request)
        } catch{
            print(error)
        }
    } 
}
