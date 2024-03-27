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
    @State private var showAlert = false
    @State private var navigateToWelcomePage = false
    @State private var tutorialAdminData: [TutorialAdmin] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 20) {
                    Button(action: {
                        // Open the URL
                        if let url = URL(string: "https://console.firebase.google.com/u/0/project/loopin-cf940/overview") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        PrimaryButton(buttonText: "Mulai Kelola Data")
                            .padding(.top, 160)
                            .padding(.bottom)
                            .padding(.leading)
                    })
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
                        showAlert.toggle()
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    })
                    .alert(isPresented: $showAlert) {
                        
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
