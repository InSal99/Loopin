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
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var postListViewModel = PostListViewModel()
    @State private var selectedSegment = 0
    let userProjects: [Project] = 
    //Disimpan di firebase
    [
        Project(name: "Cardigan", image: "test", description: "lerem ipsum", preparation: "lorem ipsum", yarntType: "Bamboo", yarnWeight: "chunky", hookSize: "D", stitchType: "Double Crochet", subPart: [
            SubPart(name: "Bagian depan", steps: [], gauge: Gauges(length: 10, width: 34, stitch: 65, row: 50)),
            SubPart(name: "Bagian depan", steps: [
                Step(title: "step title", content: "step content"),
                Step(title: "step title", content: "step content")
            ], gauge: Gauges(length: 10, width: 34, stitch: 65, row: 50))
        ], gauge: []),
        Project(name: "Cardigan", image: "test", description: "lerem ipsum", preparation: "lorem ipsum", yarntType: "Bamboo", yarnWeight: "chunky", hookSize: "D", stitchType: "Double Crochet", subPart: [
                SubPart(name: "Bagian depan", steps: [], gauge: Gauges(length: 10, width: 34, stitch: 65, row: 50))
            ], gauge: [])
    ]
    let userPosts: [Post] = []
    
    
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
                            Text("Proyek").tag(0)
                            Text("Unggahan").tag(1)
                        }
                        .pickerStyle(.segmented)
                        
                        switch selectedSegment {
                        case 0:
                            // Content for Segment 1
                            if !userProjects.isEmpty {
                                ForEach(userProjects) { selectedProject in
                                    NavigationLink(destination: ProjectDetailView(selectedProject: selectedProject)) {
                                        ProjectCard(projectName: selectedProject.name, projectDesc: selectedProject.description)
                                    }
                                }
                            } else {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .opacity(0)
                                    Text("Belum ada proyek")
                                        .padding(.top, 200)
                                        .font(.outfit(.regular, size: .body2))
                                        .opacity(0.5)
                                }
                            }
                        case 1:
                            // Content for Segment 2
                            // Add your specific content for this segment
                            // ...
                            if !userPosts.isEmpty {
                                //list user post
                            } else {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .opacity(0)
                                    Text("Belum ada unggahan")
                                        .padding(.top, 200)
                                        .font(.outfit(.regular, size: .body2))
                                        .opacity(0.5)
                                }
                            }
                        default:
                            Text("Default content")
                        }
                    }
                    .padding(.horizontal)
                }
            }
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
