//
//  ContentViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct ContentViewAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showSignOutAlert = false
    @State private var showOpenUrlAlert = false
//    @State private var navigateToWelcomePage = false
    @State private var tutorialAdminData: [TutorialAdmin] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 20) {
                    Button(action: {
                        showOpenUrlAlert.toggle()
                    }, label: {
                        PrimaryButton(buttonText: "Mulai Kelola Data")
                            .padding(.top, 160)
                            .padding(.bottom)
                            .padding(.leading)
                    })
                    .alert(isPresented: $showOpenUrlAlert) {
                        Alert(
                            title: Text("Pembukaan Situs Web"),
                            message: Text("Apakah Anda yakin ingin membuka situs web ini di browser Anda?"),
                            primaryButton: .destructive(Text("Batal")),
                            secondaryButton: .default(Text("Ya")) {
                                // Open the URL
                                if let url = URL(string: "https://console.firebase.google.com/u/0/project/loopin-cf940/overview") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        )
                    }
                    .alertButtonTint(color: .blue)
                    
                    Text("Dokumentasi")
                        .font(.outfit(.semiBold, size: .body1))
                        .padding(.leading)
                    ForEach(tutorialAdminData, id: \.self) {
                        accordionItem in Accordion(isOpened: false, title: accordionItem.title , content: accordionItem.content )
                    }
                }
            }
            .padding(.bottom)
            .navigationTitle("Dashbord Admin")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSignOutAlert.toggle()
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    })
                    .alert(isPresented: $showSignOutAlert) {
                        
                        Alert(
                            title: Text("Keluar Akun"),
                            message: Text("Apakah anda yakin ingin keluar dari akun anda?"),
                            primaryButton: .destructive(Text("Batal")),
                            secondaryButton: .default(Text("Keluar")) {
                                authViewModel.signOut { isSuccess in
                                    authViewModel.saveSignOutState()
                                }
                            }
                        )
                    }
                    .alertButtonTint(color: .blue)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                loadTutorialData()
            }
        }
        .background(Color("White"))
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadTutorialData() {
        let viewModel = JSONDataViewModel()
        tutorialAdminData = viewModel.loadTutorialAdminData()
    }
}

#Preview {
    ContentViewAdmin()
}
