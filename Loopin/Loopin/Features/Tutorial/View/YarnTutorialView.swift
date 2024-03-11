//
//  YarnTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 22/11/23.
//

import SwiftUI
import WrappingHStack

struct YarnTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    let yarn: Yarn
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    Image(yarn.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(yarn.name)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(yarn.characteristic)
                            .font(.outfit(.regular, size: .body2))
                        Text("Rekomendasi Proyek")
                            .font(.outfit(.semiBold, size: .body3))
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Sangat direkomendasikan: ")
                                .font(.outfit(.regular, size: .body2))
                            //package dependency import
                            WrappingHStack(yarn.recommend, id: \.self) { item in
                                    MiniTag(value: item)
                                    .padding(.bottom, 10)
                            }
                            Text("Kurang direkomendasikan: ")
                                .font(.outfit(.regular, size: .body2))
                            //package dependency import
                            WrappingHStack(yarn.notRecommend, id: \.self) { item in
                                    MiniTag(value: item)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.top, 300)
                    .padding()
                }
            }
            .ignoresSafeArea()
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
        .navigationBarBackButtonHidden(true)
    }
}

struct YarnTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        YarnTutorialView(yarn: Yarn(name: "name", image: "test", weight: "weight", hook: "hook", characteristic: "characteristic", recommend: [], notRecommend: []))
    }
}
