//
//  PostForumView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct PostForumView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var message = ""
    @State private var image = ""
    
    var body: some View {
        ZStack (alignment: .center){
            Rectangle()
                .fill(Color("Peach"))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 750)
                .offset(y: 40)
                .foregroundColor(Color(.white))
            VStack {
                LongTextField(placeholder: "tulis sesuatu...", field: $message)
                    .padding(.top, 90)
                ShortTextField(placeholder: "tambah gambar", field: $image)
                
                Spacer()
                Button(action: {
                    //add post to database
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    PrimaryButton(buttonText: "Kirim")
                })
            }
        }
        .navigationTitle("Unggah Forum")
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


struct PostForumView_Previews: PreviewProvider {
    static var previews: some View {
        PostForumView()
    }
}
