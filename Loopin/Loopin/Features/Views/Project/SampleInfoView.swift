//
//  SampleInfoView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct SampleInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 2, maximum: 3)
                .padding()
            ShortTextField(placeholder: "panjang sample")
            ShortTextField(placeholder: "lebar sample")
            ShortTextField(placeholder: "jumlah jahitan")
            ShortTextField(placeholder: "jumlah baris")
            Spacer()
            NavigationLink {
                ProjectPartView()
            } label: {
                PrimaryButton(buttonText: "Lanjut")
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

struct SampleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SampleInfoView()
    }
}
