//
//  ProfileView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showSignOutAlert = false
    @State private var showEditConfirmationAlert = false
//    @State private var navigateToWelcomePage = false
    @State private var isEditing = false
    @State private var text = ""
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var postListViewModel : PostListViewModel
    @EnvironmentObject var projectListViewModel: ProjectListViewModel
    @EnvironmentObject var appManager: AppManager
    
//    @ObservedObject var postListViewModel = PostListViewModel.shared
//    @ObservedObject var projectListViewModel = ProjectListViewModel.shared
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .lightGray.withAlphaComponent(0.01)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "Guava")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    private var username: String { authViewModel.authService.user?.username ?? "-" }
    private var email: String { authViewModel.authService.user?.email ?? "-" }
//    private var phone: String { authViewModel.authService.user?.phone ?? "-" }
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
                VStack (alignment: .leading, spacing: 35){
                    VStack (alignment: .leading){
                        if isEditing {
                            HStack {
                                ShortTextField(placeholder: "new username", field: $text)
                                Button(action: {
                                    showEditConfirmationAlert = true
                                }) {
                                    Label("Simpan", systemImage: "square.and.arrow.down")
                                        .font(.outfit(.semiBold, size: .body2))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                        )
                                }
                            }
                            .alert(isPresented: $showEditConfirmationAlert) {
                                var title: String = "Simpan Data"
                                var message: String = "Apakah anda yakin ingin memperbarui data username?"
                                
                                if text == "" {
                                    title = "Gagal memperbarui data"
                                    message = "Username perlu diisi"
                                    
                                    return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")) {
                                        text = username
                                        showEditConfirmationAlert = false
                                        isEditing.toggle()
                                    })
                                } else {
                                    return Alert(
                                        title: Text(title),
                                        message: Text(message),
                                        primaryButton: .default(Text("Ya")) {
                                            print("text: \(text) & username: \(username) = \(text == username )")
                                            if text != username {
                                                authViewModel.update(newUsername: text) { isSuccess  in
                                                    showEditConfirmationAlert = false
                                                    isEditing.toggle()
                                                }
                                            } else {
                                                showEditConfirmationAlert = false
                                                isEditing.toggle()
                                            }
                                        },
                                        secondaryButton: .destructive(Text("Batal")) {
                                            showEditConfirmationAlert = false
                                            isEditing.toggle()
                                        }
                                    )
                                }
                            }
                            
                        } else {
                            HStack {
                                Text(username)
                                    .font(.outfit(.semiBold, size: .heading2))
                                Button(action: {
                                    isEditing.toggle()
                                }) {
                                    Label("Ubah", systemImage: "pencil")
                                        .font(.outfit(.semiBold, size: .body2))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                        )
                                }
                            }
                        }
                        Text(email)
                            .font(.outfit(.regular, size: .body2))
                        Picker(selection: $appManager.selectedProfileSegment, label: Text("Daftar Proyek")) {
                            Text("Proyek Saya").tag(0)
                            Text("Unggahan Saya").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                        
                        switch appManager.selectedProfileSegment {
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
                                    NavigationLink {
                                        ProjectDetailView(selectedProject: projectViewModel.project)
                                            .toolbar(.hidden, for: .tabBar)
                                    } label: {
                                        ProjectCard(projectViewModel: projectViewModel)

                                    }
//                                    
//                                    NavigationLink(destination: ProjectDetailView(selectedProject: projectViewModel.project)) {
//                                        ProjectCard(projectViewModel: projectViewModel)
//                                    }
                                }
                            }
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
                                        ForumCardWithNavigation(postViewModel:postViewModel)
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
            .navigationBarBackButtonHidden(true)
            .background(Color("White"))
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
        }
        .onAppear {
            appManager.selectedContentMenuTab = 3
            text = username
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView().environmentObject(AuthenticationViewModel())
//    }
//}
