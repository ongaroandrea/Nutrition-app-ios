//
//  CreateNavigationView.swift
//  test
//
//  Created by Andrea  Ongaro on 03/04/22.
//

import SwiftUI

struct CreateNotificationView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    @Binding var error: Bool
    @State var valueDay = LocalizedStringKey("giorno_5").stringValue()
    @State var idDay: Int = 6
    
    var ogni: LocalizedStringKey = "ogni"
    var placeholder = LocalizedStringKey("placeholder_scelta_gionrni").stringValue()
    var ora = LocalizedStringKey("ora").stringValue()
    var crea: LocalizedStringKey = "crea"
    var dropDownList = [
        DropdownOption(id: 2, value: LocalizedStringKey("giorno_1").stringValue()),
        DropdownOption(id: 3, value: LocalizedStringKey("giorno_2").stringValue()),
        DropdownOption(id: 4, value: LocalizedStringKey("giorno_3").stringValue()),
        DropdownOption(id: 5, value: LocalizedStringKey("giorno_4").stringValue()),
        DropdownOption(id: 6, value: LocalizedStringKey("giorno_5").stringValue()),
    ]
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    VStack{
                        Text(placeholder)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color("Primary"))
                        
                        Menu {
                            ForEach(dropDownList, id: \.self) { client in
                                Button(client.value) {
                                    valueDay = client.value
                                    idDay = client.id
                                }
                            }
                        } label: {
                            VStack(spacing: 5) {
                                HStack {
                                    Text(valueDay.isEmpty ? placeholder : valueDay)
                                        .foregroundColor(valueDay.isEmpty ? .gray : .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color("Primary"))
                                        .font(Font.system(size: 20, weight: .bold))
                                }
                                    .padding(.horizontal)
                            }
                        }
                        .padding(15)
                        .cornerRadius(5)
                        .background(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        //Text("Your current date is \(valueDay)")
                        
                        DatePicker(ora, selection: $date, displayedComponents: [.hourAndMinute])
                            .padding(10)
                            .datePickerStyle(.graphical)
                            .background(.white)
                    }
                    
                    Button {
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                        notificationManager.createLocalNotification( title: ogni.stringValue() + valueDay, hour: dateComponents.hour!, minute: dateComponents.minute!, weekDay: idDay) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.error = true
                                    print("error")
                                }
                            }
                        }
                    } label: {
                        Text(crea)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .onDisappear {
            notificationManager.reloadLocalNotifications()
        }
        .navigationBarItems(trailing: Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
    }
}


struct CreateNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView(
            notificationManager: NotificationManager(),
            isPresented: .constant(false), error: .constant(false)
        )
    }
}

struct DropdownOption: Identifiable, Hashable {
    let id: Int
    let value: String
}


extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        
        let language = locale.languageCode
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
}

extension LocalizedStringKey {
    var stringKey: String {
        let description = "\(self)"
        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }
        return components[1][0]
    }
    
    func stringValue(locale: Locale = .current) -> String {
            return .localizedString(for: self.stringKey, locale: locale)
    }
}
