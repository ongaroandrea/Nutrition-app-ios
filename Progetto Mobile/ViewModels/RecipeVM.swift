//
//  RecipeVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 30/05/22.
//

import Foundation
import GRDB

class RecipeVM: DataWrapper, ObservableObject {
    
    @Published var listRecips: [Recipe] = []
    @Published var recipe: Recipe? = nil
    
    func getRecipeByID(idRecipe: Int){
        print("ID test")
        print(idRecipe)
        do {
            try getDatabase().write { db in
                recipe = try Recipe
                    .filter(Column("id") == idRecipe)
                    .fetchOne(db)
            }
        } catch{
            print(error)
            
        }
    }
    
    func loadAll(){
        
        do {
            try getDatabase().write { db in
                listRecips = try Recipe
                    .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func loadAllR() -> [Recipe] {
        
        do {
            try getDatabase().write { db in
                listRecips = try Recipe
                    .fetchAll(db)
            }
        } catch{
            return []
        }
        return listRecips
    }
}
