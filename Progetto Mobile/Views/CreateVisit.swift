//
//  CreateVisit.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 21/05/22.
//

import SwiftUI

struct CreateVisit: View {
    
    @ObservedObject var visitManager: visitVM
    @Binding var isPresented: Bool
    @State private var wakeUp = Date.now
    @State var isError: Bool = false
    var errore: LocalizedStringKey = "errore"
    
    var body: some View {
        VStack{
            Text("Prenota il tuo appuntamento")
                .font(.title)
                .bold()
                .foregroundColor(Color("Primary"))
            Spacer()
            DatePicker("", selection: $wakeUp)
                .labelsHidden()
            
            Button{
                let response = visitManager.addVisit(day: wakeUp)
                if response {
                    isError = true
                } else {
                    self.isPresented = false
                    print(visitManager.listVisits)
                    isError = false
                }
                
            }
            label: {
                Text("Conferma Appuntamento")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
            .alert(isPresented: $isError) {
                Alert(title: Text(errore.stringValue()), message: Text("Data non disponibile per l'appuntamento"), dismissButton: .default(Text("Ok!")))
            }
            Spacer()
        }
        .listStyle(.plain)
        .onDisappear {
            visitManager.getAllVisitByUserID()
        }
        .navigationBarItems(trailing: Button {
            self.isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
       
    }
}

struct CreateVisit_Previews: PreviewProvider {
    static var previews: some View {
        CreateVisit(
            visitManager: visitVM(),
            isPresented: .constant(false))
    }
}
