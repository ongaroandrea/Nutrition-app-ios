//
//  Account.swift
//  test
//
//  Created by Andrea  Ongaro on 27/03/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var opdata: OpDat
    let modifica_dati : LocalizedStringKey = "modifica_dati"
    let face_id : LocalizedStringKey = "face_id"
    let notifiche_allenamenti : LocalizedStringKey = "notifiche_allenamenti"
    let terms : LocalizedStringKey = "terms"
    
    var body: some View {
        NavigationView {
            List{
                Section(header: ProfileView()) {
                    NavigationLink(
                        destination: AccountView(),
                        label: {
                            Label {
                                Text(modifica_dati)
                                    .foregroundColor(Color("TextColor"))
                                    .bold()
                                    .opacity(0.50)
                                    .padding(.horizontal, 10)
                            } icon: {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .padding(10)
                                    .background(Color("light_yellow"))
                                    .cornerRadius(10)
                            }
                        }
                    )
                    
                    .listRowSeparator(.hidden)
                    
                    NavigationLink(
                        destination: FaceIDView(),
                        label: {
                            Label {
                                Text(face_id)
                                    .foregroundColor(Color("TextColor"))
                                    .bold()
                                    .opacity(0.50)
                                    .padding(.horizontal, 10)
                            } icon: {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .padding(10)
                                    .background(Color("light_yellow"))
                                    .cornerRadius(10)
                            }
                        }
                    )
                    .listRowSeparator(.hidden)
                    
                    NavigationLink(
                        destination: NotificationView(),
                        label: {
                            Label {
                                Text(notifiche_allenamenti)
                                    .foregroundColor(Color("TextColor"))
                                    .bold()
                                    .opacity(0.50)
                                    .padding(.horizontal, 10)
                            } icon: {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .padding(10)
                                    .background(Color("light_yellow"))
                                    .cornerRadius(10)
                            }
                        }
                    )
                    .listRowSeparator(.hidden)
                    
                    Divider()
                        
                    
                    NavigationLink(
                        destination: EmptyView(),
                        label: {
                            Label {
                                Text(terms)
                                    .foregroundColor(Color("TextColor"))
                                    .bold()
                                    .opacity(0.50)
                                    .padding(.horizontal, 10)
                            } icon: {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .padding(10)
                                    .background(Color("light_yellow"))
                                    .cornerRadius(10)
                            }
                        }
                    )
                    .listRowSeparator(.hidden)
                    
                    NavigationLink(
                        destination: LogoutView().environmentObject(opdata),
                        label: {
                            Label {
                                Text("Logout")
                                    .foregroundColor(Color("TextColor"))
                                    .bold()
                                    .opacity(0.50)
                                    .padding(.horizontal, 10)
                            } icon: {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .padding(10)
                                    .background(Color("light_yellow"))
                                    .cornerRadius(10)
                            }
                        }
                    )
                    .listRowSeparator(.hidden)
                }
                .padding(.horizontal)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .listStyle(.plain)
        }
        
    }
}
        

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct ProfileView: View {
    @StateObject private var viewModel: UserVM = UserVM()
    var body: some View {
        VStack(spacing: 10) {
                Image("no image")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color("accentColor"), lineWidth: 5))
                    .padding(.bottom, 10)
            
                HStack{
                    Text(viewModel.userLogged?.name ?? "test")
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                    Text(viewModel.userLogged?.surname ?? "test")
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                }
                

                Text(viewModel.userLogged?.sport ?? "null")
                    .foregroundColor(Color("TextColor"))
                    .opacity(0.45)

        }
        .onAppear(perform: {
            //print(KeychainStorage.getCredentials()!.id)
            viewModel.setCurrentUser()
        })
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 50)
    }
}
