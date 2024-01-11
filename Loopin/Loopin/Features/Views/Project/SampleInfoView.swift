//
//  SampleInfoView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct SampleInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var project: Project

    @State private var height = ""
    @State private var width = ""
    @State private var totalStitch = ""
    @State private var totalRow = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 2, maximum: 3)
                .padding()
            ShortTextField(placeholder: "panjang sample", field: $height)
            ShortTextField(placeholder: "lebar sample", field: $width)
            ShortTextField(placeholder: "jumlah jahitan", field: $totalStitch)
            ShortTextField(placeholder: "jumlah baris", field: $totalRow)
            Spacer()
            NavigationLink {
                ProjectPartView(project: project)
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
        SampleInfoView(project: Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], samples: []))
    }
}
