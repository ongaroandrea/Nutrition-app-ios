//
//  File.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 06/04/22.
//

import Foundation
import GRDB

class DataWrapper {
    
    private var db: DatabaseQueue?;
    
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
    }
    
    func initialize() {
        createUsersTable()
        createVisitsTable()
        createMisurationTakenTable()
        createFoodTable()
        createFoodUsedTable()
        createRecipesTable()
        createSensationTable()
        insertUser()
        insertLanguage()
        insertFood()
        insertFoodUsed()
        insertVisits()
        insertMisurationTaken()
        insertRecipe()
        insertSensation()
    }
    func getDatabase() -> DatabaseQueue {
        return self.db!
    }
    
    func createUsersTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(User.databaseTableName)
                if(response){
                    try db.drop(table: User.databaseTableName)
                }
                try db.create(table: User.databaseTableName) { t in
                    t.column("id", .text).notNull().primaryKey()
                    t.column("name", .text).notNull()
                    t.column("surname", .text).notNull()
                    t.column("email", .text).notNull()
                    t.column("password", .text).notNull()
                    t.column("dataNascita", .text).notNull()
                    t.column("sport", .text).notNull()
                }
            }
        } catch {
            print(error)
        }
    }

    
    func createVisitsTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(Visit.databaseTableName)
                if(response){
                    print("eliminazione notification")
                    try db.drop(table: Visit.databaseTableName)
                }
                try db.create(table: Visit.databaseTableName) { t in
                    t.column("id", .text).notNull().primaryKey()
                    t.column("date", .date).notNull()
                    t.column("userID", .text).notNull()
                        .notNull()
                        .indexed()
                        .references("user", onDelete: .cascade)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func createRecipesTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(Recipe.databaseTableName)
                if(response){
                    print("eliminazione notification")
                    try db.drop(table: Recipe.databaseTableName)
                }
                try db.create(table: Recipe.databaseTableName) { t in
                    t.column("id", .text).notNull().primaryKey()
                    t.column("title", .text).notNull()
                    t.column("time", .text).notNull()
                    t.column("image", .text).notNull()
                    t.column("difficulty", .text).notNull()
                    t.column("description", .text).notNull()
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    func createMisurationTakenTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(MisurationTaken.databaseTableName)
                if(response){
                    print("eliminazione notification")
                    try db.drop(table: MisurationTaken.databaseTableName)
                }
                try db.create(table: MisurationTaken.databaseTableName) { t in
                    t.column("id", .text).notNull().primaryKey()
                    t.column("type", .text).notNull()
                    t.column("value", .double).notNull()
                    t.column("visitID", .text).notNull()
                        .notNull()
                        .indexed()
                        .references("visit", onDelete: .cascade)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func createSensationTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(Sensation.databaseTableName)
                if(response){
                    print("eliminazione notification")
                    try db.drop(table: Sensation.databaseTableName)
                }
                try db.create(table: Sensation.databaseTableName) { t in
                    t.column("id", .text).notNull().primaryKey()
                    t.column("description", .text).notNull()
                    t.column("date", .date).notNull()
                    t.column("userID", .text)
                        .notNull()
                        
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    func createFoodTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(Food.databaseTableName)
                if(response){
                    print("eliminazione notification")
                    try db.drop(table: Food.databaseTableName)
                }
                try db.create(table: Food.databaseTableName) { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("name", .text).notNull()
                    t.column("calories", .double).notNull()
                }
            }
        } catch {
            print(error)
        }
    }
    
    func createFoodUsedTable(){
        do {
            try self.db!.write { db in
                let response = try db.tableExists(FoodUsed.databaseTableName)
                if(response){
                    print("eliminazione notification")
                    try db.drop(table: FoodUsed.databaseTableName)
                }
                try db.create(table: FoodUsed.databaseTableName) { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("foodID", .integer).notNull()
                        .notNull()
                        .indexed()
                        .references("food", onDelete: .cascade)
                    t.column("quantity", .integer).notNull()
                    t.column("visit_state", .text).notNull()
                    t.column("day", .integer).notNull()
                    t.column("dietsID", .integer).notNull()
                }
            }
        } catch {
            print(error)
        }
    }
    
    func insertUser(){
        do {
            try self.db!.write { db in
                try User(id: "3523523523", name: "Arthur", surname: "Loga", email: "andreaongaro", password: "bello6", dataNascita: "26/02/2012", sport: "Calisthenics" ).insert(db)
                try User(id: "3523532523", name: "Marilosky", surname: "Loga", email: "andrea@yahho.it", password: "asdsdfsf", dataNascita: "26/02/2012", sport: "Nuoto").insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insertVisits() {
        let date: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 5, day: 27, hour: 18, minute: 50))!
        let date1: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 3, day: 20, hour: 18, minute: 50))!
        let date2: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 1, day: 15, hour: 18, minute: 50))!
        let date3: Date = Calendar.current.date(from: DateComponents(year: 2021, month: 10, day: 27, hour: 18, minute: 50))!
        
        do {
            try self.db!.write { db in
                try Visit(id: "1", date: date, userID: "3523523523").insert(db)
                try Visit(id: "2", date: date1, userID: "3523523523").insert(db)
                try Visit(id: "3", date: date2, userID: "3523523523").insert(db)
                try Visit(id: "4", date: date3, userID: "3523523523").insert(db)
                try Visit(id: "5", date: date3, userID: "3523532523").insert(db)
            }
        } catch {
            print(error)
        }
    }

    func insertLanguage(){
        do {
            try self.db!.write { db in
                try Language(id: 1, name: "Italiano").insert(db)
                try Language(id: 2, name: "Inglese").insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insertFood(){
        do {
            try self.db!.write { db in
                try Food(id: 1, name: "Pasta Integrale", calories: 50.5).insert(db)
                try Food(id: 2, name: "Bresaola", calories: 30.5).insert(db)
                try Food(id: 3, name: "Miele", calories: 50.5).insert(db)
                try Food(id: 4, name: "Latte di vacca parz. scremato", calories: 150.5).insert(db)
                try Food(id: 5, name: "Fiocchi d'avena", calories: 150.5).insert(db)
                try Food(id: 6, name: "Frutta fresca", calories: 150.5).insert(db)
                try Food(id: 7, name: "Mandorle", calories: 150.5).insert(db)
                try Food(id: 8, name: "Noci", calories: 150.5).insert(db)
                try Food(id: 9, name: "Riso", calories: 150.5).insert(db)
                try Food(id: 10, name: "Olio d'oliva extra vergine", calories: 150.5).insert(db)
                try Food(id: 11, name: "Verdure miste", calories: 150.5).insert(db)
                try Food(id: 12, name: "Petto di pollo", calories: 150.5).insert(db)
                try Food(id: 13, name: "Pane integrale", calories: 150.5).insert(db)
                try Food(id: 14, name: "Vitello", calories: 150.5).insert(db)
                try Food(id: 15, name: "Gallette di mais", calories: 150.5).insert(db)
                try Food(id: 16, name: "Crackers integrali", calories: 150.5).insert(db)
                try Food(id: 17, name: "Parmigiano", calories: 150.5).insert(db)
                try Food(id: 18, name: "Pesci di mare", calories: 150.5).insert(db)
                try Food(id: 19, name: "Patate", calories: 150.5).insert(db)
                try Food(id: 20, name: "Tisana in tazza", calories: 150.5).insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insertFoodUsed(){
        do {
            try self.db!.write { db in
                try FoodUsed(id: 1, foodID: 2, quantity: 100, visit_state: "Colazione", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 1, foodID: 2, quantity: 100, visit_state: "Colazione", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 1, foodID: 2, quantity: 100, visit_state: "Colazione", day: 1, dietsID: 1).insert(db)
                
                try FoodUsed(id: 2, foodID: 3, quantity: 100, visit_state: "Merenda1", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 2, foodID: 3, quantity: 100, visit_state: "Merenda1", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 2, foodID: 3, quantity: 100, visit_state: "Merenda1", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 2, foodID: 3, quantity: 100, visit_state: "Merenda1", day: 1, dietsID: 1).insert(db)
                
                try FoodUsed(id: 3, foodID: 2, quantity: 100, visit_state: "Pranzo", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 3, foodID: 2, quantity: 100, visit_state: "Pranzo", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 3, foodID: 2, quantity: 100, visit_state: "Pranzo", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 3, foodID: 2, quantity: 100, visit_state: "Pranzo", day: 1, dietsID: 1).insert(db)
                
                try FoodUsed(id: 4, foodID: 2, quantity: 100, visit_state: "Merenda2", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 4, foodID: 2, quantity: 100, visit_state: "Merenda2", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 4, foodID: 2, quantity: 100, visit_state: "Merenda2", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 4, foodID: 2, quantity: 100, visit_state: "Merenda2", day: 1, dietsID: 1).insert(db)
                
                try FoodUsed(id: 5, foodID: 2, quantity: 100, visit_state: "Cena", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 5, foodID: 2, quantity: 100, visit_state: "Cena", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 5, foodID: 2, quantity: 100, visit_state: "Cena", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 5, foodID: 2, quantity: 100, visit_state: "Cena", day: 1, dietsID: 1).insert(db)
                try FoodUsed(id: 5, foodID: 2, quantity: 100, visit_state: "Cena", day: 1, dietsID: 1).insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insertSensation(){
        do {
            try self.db!.write { db in
                let date: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 5, day: 27, hour: 18, minute: 50))!
                let date1: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 3, day: 20, hour: 09, minute: 50))!
                try Sensation(date: date, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus sapien ut lorem fringilla semper. Nullam eget laoreet quam, eget pellentesque erat. Pellentesque interdum, massa ac efficitur sollicitudin, ", userID: "3523523523").insert(db)
                
                try Sensation(date: date1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus sapien ut lorem fringilla semper. Nullam eget laoreet quam, eget pellentesque erat. Pellentesque interdum, massa ac efficitur sollicitudin, ", userID: "3523523523").insert(db)
                
            }
        } catch {
            print(error)
        }
    }
    
    func insertRecipe(){
        do {
            try self.db!.write { db in
                try Recipe(id: 1, title: "Pancake", time: "11:00", image: "pancake", difficulty: 5, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus sapien ut lorem fringilla semper. Nullam eget laoreet quam, eget pellentesque erat. Pellentesque interdum, massa ac efficitur sollicitudin, metus erat vestibulum lorem, id pharetra ex enim ac nibh. Nulla vitae nibh in metus maximus dapibus in nec massa. Curabitur finibus, eros non faucibus posuere, nisi massa bibendum lorem, sit amet viverra orci enim quis mauris. Ut sed suscipit purus. Nulla facilisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras quis suscipit velit. Quisque purus enim, euismod at suscipit vitae, ultricies nec diam. Vivamus euismod sit amet nunc auctor volutpat. Phasellus nec odio eu est sodales convallis. Aliquam vel ligula a elit eleifend cursus.").insert(db)
                try Recipe(id: 2, title: "Pasta", time: "11:00", image: "pasta", difficulty: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus sapien ut lorem fringilla semper. Nullam eget laoreet quam, eget pellentesque erat. Pellentesque interdum, massa ac efficitur sollicitudin, metus erat vestibulum lorem,").insert(db)
                try Recipe(id: 3, title: "Sgarro", time: "11:00", image: "Sgarro", difficulty: 1, description: "tanta").insert(db)
                try Recipe(id: 4, title: "Pollo", time: "11:00", image: "pollo", difficulty: 2, description: "tanta").insert(db)
                try Recipe(id: 5, title: "Insalata", time: "11:00", image: "insalata", difficulty: 5, description: "tanta").insert(db)
                try Recipe(id: 6, title: "Insalata", time: "11:00", image: "riso", difficulty: 5, description: "tanta").insert(db)
                try Recipe(id: 7, title: "Avocado", time: "11:00", image: "Avocado", difficulty: 5, description: "tanta").insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insertMisurationTaken(){
        do {
            try self.db!.write { db in
                try MisurationTaken(type: "Weight", value: 76.6, visitID: "1").insert(db)
                try MisurationTaken(type: "Weight", value: 74.4, visitID: "2").insert(db)
                try MisurationTaken(type: "Weight", value: 71.8, visitID: "3").insert(db)
                try MisurationTaken(type: "Weight", value: 70.1, visitID: "4").insert(db)
                try MisurationTaken(type: "Weight", value: 71.5, visitID: "5").insert(db)
                try MisurationTaken(type: "Byceps", value: 28, visitID: "1").insert(db)
                try MisurationTaken(type: "Byceps", value: 28.5, visitID: "2").insert(db)
                try MisurationTaken(type: "Byceps", value: 28.5, visitID: "3").insert(db)
                try MisurationTaken(type: "Byceps", value: 27, visitID: "4").insert(db)
                try MisurationTaken(type: "Byceps", value: 28, visitID: "5").insert(db)
                try MisurationTaken(type: "Core", value: 75.5, visitID: "1").insert(db)
                try MisurationTaken(type: "Core", value: 76.0, visitID: "2").insert(db)
                try MisurationTaken(type: "Core", value: 74.5, visitID: "3").insert(db)
                try MisurationTaken(type: "Core", value: 72.0, visitID: "4").insert(db)
                try MisurationTaken(type: "Core", value: 74.0, visitID: "5").insert(db)
                try MisurationTaken(type: "BMI", value: 25.0, visitID: "1").insert(db)
                try MisurationTaken(type: "BMI", value: 24.4, visitID: "2").insert(db)
                try MisurationTaken(type: "BMI", value: 23.4, visitID: "3").insert(db)
                try MisurationTaken(type: "BMI", value: 22.9, visitID: "4").insert(db)
                try MisurationTaken(type: "BMI", value: 23.3, visitID: "5").insert(db)
                try MisurationTaken(type: "Hydration", value: 73, visitID: "2").insert(db)
                
                try MisurationTaken(type: "FFM", value: 23.3, visitID: "5").insert(db)
                try MisurationTaken(type: "BMI", value: 23.3, visitID: "5").insert(db)
                try MisurationTaken(type: "TBW", value: 23.3, visitID: "5").insert(db)
                try MisurationTaken(type: "BCM", value: 23.3, visitID: "5").insert(db)
                try MisurationTaken(type: "FM", value: 23.3, visitID: "5").insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func getSystemLanguage() -> String{
        if(Locale.current.languageCode! == "it") {
            return "1"
        }
        else{
            return "2"
        }
            
    }
}
