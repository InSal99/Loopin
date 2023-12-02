//
//  ProjectPartView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectPartView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 3, maximum: 3)
                .padding()
            ForEach(1...3, id: \.self) { item in
                ProjectPartInputCard(placeholder1: "Panjang", placeholder2: 70)
            }
            Spacer()
            Button(action: {
                showAlert = true
            }) {
                PrimaryButton(buttonText: "Simpan Proyek")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Simpan Proyek"),
                    message: Text("Apakah anda yakin ingin menyimpan projek?"),
                    primaryButton: .default(Text("Yes")) {
                        presentationMode.wrappedValue.dismiss()
                        ProfileView()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationTitle("Info Sampel")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct ProjectPartView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPartView()
    }
}
