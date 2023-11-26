//
//  ProjectInfoView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 1, maximum: 3)
                .padding()
            ShortTextField(placeholder: "nama")
            LongTextField(placeholder: "deskripsi proyek")
            ShortTextField(placeholder: "jenis benang")
            ShortTextField(placeholder: "ketebalan benang")
            ShortTextField(placeholder: "ukuran hakpen")
            ShortTextField(placeholder: "jenis jahitan")
            Spacer()
            NavigationLink {
                SampleInfoView()
            } label: {
                PrimaryButton(buttonText: "Lanjut")
            }
        }
        .navigationTitle("Info Proyek")
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

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoView()
    }
}
