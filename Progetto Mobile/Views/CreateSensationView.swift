//
//  CreateSensationView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 22/05/22.
//

import SwiftUI

struct CreateSensationView: View {
    
    let come_sentito : LocalizedStringKey = "come_sentito"
    @StateObject var viewModel: SensationVM = SensationVM()
    @EnvironmentObject private var opdata: OpDat
    @EnvironmentObject private var delegate: AppDelegate
    @State private var text: String = ""
    @State private var showingAlert = false
    let errore : LocalizedStringKey = "errore"
    var body: some View {
        VStack(spacing: 30){
            Text(come_sentito)
                .font(.title)
                .bold()
                .foregroundColor(Color("Primary"))
            
            TextEditor(text: $text)
                .foregroundColor(Color.gray)
                .border(.clear, width: 0)
                .padding()
                .lineSpacing(2.0)
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    )
                .font(.custom("HelveticaNeue", size: 13))
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 4)
            Button{
                print("ok")
                let result = viewModel.createSensation(description: text)
                print(result)
                if result {
                    opdata.currView = .home
                    delegate.openedFromNotification = false
                    showingAlert = false
                    print("Male male")
                } else {
                    showingAlert = true
                }
                print(text)
            } label: {
                Text("Inserisci")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(errore.stringValue()), message: Text(""), dismissButton: .default(Text("Ok!")))
            }
            Spacer()
        }
        .padding()
    }
}

struct CreateSensationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSensationView()
    }
}
