//
//  ProfileView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var navigateToWelcomePage = false
    @State private var selectedSegment = 0
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var postListViewModel = PostListViewModel()
    @ObservedObject var projectListViewModel = ProjectListViewModel.shared

    let userProjects: [Project] =
    //Disimpan di firebase
    [
        Project(type: "Cardigan", name: "Cardiganku", image: "test", description: "lerem ipsum", preparation: "lorem ipsum", yarnType: "Bamboo", yarnWeight: "chunky", hookSize: "D", stitchType: "Double Crochet", subParts: [
            SubPart(name: "Bagian depan", steps: [], gauge: Gauges(length: 10, width: 34, stitch: 65, row: 50)),
            SubPart(name: "Bagian depan", steps: [
                Step(text: "step title", nums: 0, isStitch: false, guidances: []),
                Step(text: "step title", nums: 0, isStitch: false, guidances: ["test", "test"]),
            ], gauge: Gauges(length: 10, width: 34, stitch: 65, row: 50))
        ], sample: Gauges(length: 6, width: 6, stitch: 6, row: 6)),
        Project(type: "Cardigan", name: "Cardiganku", image: "test", description: "lerem ipsum", preparation: "lorem ipsum", yarnType: "Bamboo", yarnWeight: "chunky", hookSize: "D", stitchType: "Double Crochet", subParts: [
            SubPart(name: "Bagian depan", steps: [], gauge: Gauges(length: 10, width: 34, stitch: 65, row: 50))
        ], sample: Gauges(length: 6, width: 6, stitch: 6, row: 6))
    ]
//    let userPosts: [Post] = []
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .lightGray.withAlphaComponent(0.01)
       UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
       UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "Guava")
       UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
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
                            
                            if projectListViewModel.projectViewModels.isEmpty {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .opacity(0)
                                    Text("Belum ada proyek")
                                        .padding(.top, 200)
                                        .font(.outfit(.regular, size: .body2))
                                        .opacity(0.5)
                                }
                            } else {
                                ForEach(projectListViewModel.projectViewModels) { projectViewModel in
                                    NavigationLink(destination: ProjectDetailView(selectedProject: projectViewModel.project)) {
                                        ProjectCard(projectName: projectViewModel.project.name, projectDesc: projectViewModel.project.description)
                                    }
                                }
                            }
//                            if !userProjects.isEmpty {
//                                ForEach(userProjects) { selectedProject in
//                                    NavigationLink(destination: ProjectDetailView(selectedProject: selectedProject)) {
//                                        ProjectCard(projectName: selectedProject.name, projectDesc: selectedProject.description)
//                                    }
//                                }
//                            } else {
//                                ZStack(alignment: .center) {
//                                    Rectangle()
//                                        .opacity(0)
//                                    Text("Belum ada proyek")
//                                        .padding(.top, 200)
//                                        .font(.outfit(.regular, size: .body2))
//                                        .opacity(0.5)
//                                }
//                            }
                        case 1:
                            // Content for Segment 2
                            if postListViewModel.postViewModels.isEmpty {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .opacity(0)
                                        Text("Belum ada unggahan")
                                            .padding(.top, 200)
                                            .font(.outfit(.regular, size: .body2))
                                            .opacity(0.5)
                                }
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
            .background(Color("White"))
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
