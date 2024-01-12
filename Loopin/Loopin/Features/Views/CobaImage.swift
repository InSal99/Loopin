//
//  CobaImage.swift
//  Loopin
//
//  Created by Celine Margaretha on 12/01/24.
//

import Foundation
import SwiftUI
import Firebase

struct CobaImageView: View {
    @Binding var selectedImage: UIImage?
    @State private var sourceType: ImagePicker.SourceType = .photoLibrary
    @State private var showImagePicker = false
    var onClear: () -> Void
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Text("No image selected")
            }
            
            HStack() {
                VStack() {
                    Button(action: {}) {
                        Menu {
                            Button(action: {
                                selectedImage = nil // Reset any previous selection
                                sourceType = .photoLibrary
                                showImagePicker.toggle()
                            }) {
                                Text("Photo Library")
                            }
                            .padding(.horizontal, 5)
                           
                            
                            Button(action: {
                                selectedImage = nil // Reset any previous selection
                                sourceType = .camera
                                showImagePicker.toggle()
                            }) {
                                Text("Camera")
                            }
                            .padding(.horizontal, 5)
//                            .sheet(isPresented: $showImagePicker) {
//                                ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
//                            }
                        }
                    label: {
                        Text("Choose Photo").tag(ImagePicker.SourceType.camera)
                        
                    }
                    .padding(.horizontal, 5)
                    .padding(.leading, 8)
                    .padding(.vertical, 5)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
                Button("Clear") {
                    selectedImage = nil
                    onClear() // Notify the parent view
                }
                .disabled(selectedImage == nil)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
            }
            
        }
        .padding()
        
        //            Button("Upload Image") {
        //                imageViewModel.uploadImage { result in
        //                    switch result {
        //                    case .success(let imageURL):
        //                        print("Image uploaded successfully. URL: \(imageURL)")
        //                    case .failure(let error):
        //                        print("Error uploading image: \(error.localizedDescription)")
        //                    }
        //                }
        //            }
        //            .padding()
        
    }
}

//struct CobaImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CobaImageView()
//    }
//}

