//
//  ProjectsViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 07/03/24.
//

import SwiftUI

struct ProjectsViewAdmin: View {
    @State private var isProjectOverviewViewPresented = false
    @State private var projectTemplateData: [ProjectTemplateJSON] = []
    @State private var showDeleteAlert = false
    @State private var isEditProjectViewPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ForEach(projectTemplateData) { templateItem in
                    NavigationLink(destination: ProjectOverviewViewAdmin(projectTemplate: templateItem)) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 20)
                                HStack(alignment: .center) {
                                    Image(templateItem.image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(15)
                                    Text(templateItem.name)
                                        .font(.outfit(.semiBold, size: .body2))
                                        .foregroundColor(Color("Black"))
                                        .padding(.horizontal, 10)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Button(action: {}) {
                                        Menu {
                                            Button(action: {
                                                isEditProjectViewPresented.toggle()
                                            }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .padding(.horizontal, 5)
                                            
                                            Button(action: {
                                                showDeleteAlert.toggle()
                                                print("heee")
                                            }) {
                                                Label("Hapus", systemImage: "trash")
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.horizontal, 5)
                                        }
                                    label: {
                                        Image(systemName: "ellipsis.circle")
                                            .foregroundColor(.black)
                                            .scaleEffect(1.2)
                                    }
                                    .padding(.horizontal, 5)
                                    .padding(.leading, 8)
                                    .padding(.vertical, 5)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
                        }
                        .sheet(isPresented: $isEditProjectViewPresented) {
                            //edit page
                        }
                        .alert(isPresented: $showDeleteAlert) {
                            Alert(
                                title: Text("Hapus Proyek"),
                                message: Text("Apakah anda yakin ingin menghapus proyek?"),
                                primaryButton: .destructive(Text("Batal")),
                                secondaryButton: .default(Text("Hapus")) {
                                    //delete term action
                                }
                            )
                        }

                    }
            }
            .navigationTitle("Proyek")
            .navigationBarBackButtonHidden(true)
            .background(Color("White"))
            .onAppear {
                loadProjectTemplateData()
            }
        }
    }
    
    func loadProjectTemplateData() {
        let viewModel = JSONDataViewModel()
        projectTemplateData = viewModel.loadProjectTemplateData()
    }
}

#Preview {
    ProjectsViewAdmin()
}
