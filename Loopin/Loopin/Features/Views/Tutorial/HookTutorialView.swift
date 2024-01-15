//
//  HookTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct HookTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    private let title: String = "Cara Memegang Hakpen"
    private let content: String =  "Pegang bagian datar dari hakpen dengan jari ibu jari dan jari telunjuk Anda, lihat posisi ibu jari pada hakpen, dan tempatkan ibu jari tangan dominan anda sambil mencubit sisi belakang dengan jari telunjuk anda. Letakkan hakpen di atas jari tengah seperti memegang pensil, dengan sisa jari Anda mengarah ke telapak tangan, dan biarkan hakpen berada di jari tengah seperti memegang pensil. Gunakan jari Anda untuk mengarahkan hakpen saat merajut, cocok untuk yang suka menjaga jari dekat dengan jahitan atau meletakkan jari telunjuk di atas ikatan yang sedang dirajut. Cara memegang ini adalah metode yang baik untuk pemula."
    private let images = ["HookTutorial-1", "HookTutorial-2", "HookTutorial-3"]
    @State private var accordionData: [Hook] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    ImageSlider(images: images)
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(content)
                            .font(.outfit(.regular, size: .body2))
                        Text("Rekomendasi")
                            .font(.outfit(.semiBold, size: .body3))
                        ForEach(accordionData, id: \.self) {
                            accordionItem in Accordion(isOpened: false, title: accordionItem.title , content: accordionItem.content )
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
            .onAppear {
                loadAccordionData()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadAccordionData() {
        let viewModel = JSONDataViewModel()
        accordionData = viewModel.loadHookData()
    }
}

struct HookTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        HookTutorialView()
    }
}
