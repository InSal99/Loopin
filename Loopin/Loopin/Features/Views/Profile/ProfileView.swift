//
//  ProfileView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var navigateToWelcomePage = false
    @State private var isPostForumViewPresented = false
    @State private var selectedSegment = 0

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var postListViewModel = PostListViewModel()

    
    var userName: String { authViewModel.authService.user?.username ?? "Kim Kimhan" }
    var email: String { authViewModel.authService.user?.email ?? "kimkimhan@mail.com" }
    var phone: String { authViewModel.authService.user?.phone ?? "0812345667890" }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack (alignment: .leading, spacing: 35){
                    VStack (alignment: .leading){
                        Text(userName)
                            .font(.outfit(.medium, size: .body1))
                        Text(email)
                            .font(.outfit(.regular, size: .body2))
                        Text(phone)
                            .font(.outfit(.regular, size: .body2))
                        Picker(selection: $selectedSegment, label: Text("Daftar Proyek")) {
                            Text("Proyek Saya").tag(0)
                            Text("Unggahan Saya").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                        
                        switch selectedSegment {
                        case 0:
                            // Content for Segment 1
                            ForEach(1...5, id: \.self) { item in
                                NavigationLink {
                                    ProjectDetailView()
                                } label: {
                                    ProjectCard(projectName: "Cardigan", projectDesc: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.")
                                }
                            }
                        case 1:
                            // Content for Segment 2
                            
                            if postListViewModel.postViewModels.isEmpty {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Button{
                                        isPostForumViewPresented.toggle()
                                    } label: {
                                        Text("Buat unggahan barumu")
                                    }
                                    .sheet(isPresented: $isPostForumViewPresented) {
                                        PostForumView()
                                    }
                                    .foregroundColor(Color("Black"))
                                    .buttonStyle(.bordered)
                                    Spacer()
                                }
                                .frame(height: UIScreen.main.bounds.height - 400)
                                
                            } else {
                                ForEach(postListViewModel.postViewModels) { postViewModel in
                                    if postViewModel.isAllowedToEdit {
                                        ForumCard(postViewModel:postViewModel)
                                    }
                                }
                            }
                           
                        default:
                            Text("Default content")
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom)
            .navigationTitle("Profile")
            .navigationBarBackButtonHidden(true)
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
                            primaryButton: .default(Text("Yes")) {
                                authViewModel.authService.signOut()
                                
                                navigateToWelcomePage.toggle()
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .background(
                        NavigationLink(destination: WelcomePage(), isActive: $navigateToWelcomePage) {
                            EmptyView()
                        }
                    )
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthenticationViewModel())
    }
}
