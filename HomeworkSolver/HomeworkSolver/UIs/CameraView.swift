//
//  CameraView.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import SwiftUI

struct CameraView: View {
  @Binding var expression: String
  @Binding var appear: Bool
  @Binding var processing: Bool
  @State private var showingImagePicker = false
  @State private var image: UIImage?
  @State private var showingCamera = false
  
  func image2expression() {
    processing = true
    if let image = image {
      DispatchQueue.global(qos: .userInitiated).async {
        sendImageRequest(image: image) { expression in
          DispatchQueue.main.async {
   
            self.expression = removeLeftOfEqualSign(from: expression)
            processing = false
          }
        }
      }
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button(action: {
          image2expression()
          appear = false
        }) {
          Text("Done")
            .font(.headline)
            .padding()
        }
      }
      .padding()
      
      if image == nil {
        VStack {
          Spacer()
          HStack {
            Spacer()
            Button(action: {
              showingCamera = true
              showingImagePicker = true
            }) {
              Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()
            }
            Spacer()
            Button(action: {
              showingCamera = false
              showingImagePicker = true
            }) {
              Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()
            }
            Spacer()
          }
          Spacer()
        }
      } else {
        VStack {
          Spacer()
          Image(uiImage: image!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          Spacer()
          HStack {
            Spacer()
            Button(action: {
              image = nil
            }) {
              Image(systemName: "arrow.triangle.2.circlepath")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding()
            }
            Spacer()
          }
        }
      }
    }
    .sheet(isPresented: $showingImagePicker) {
      ImagePicker(image: self.$image, isCamera: self.$showingCamera)
        .ignoresSafeArea()
    }
    .onDisappear {
      if image != nil {
        image2expression()
      }
    }
  }
}

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  @Binding var isCamera: Bool
  @Environment(\.presentationMode) var presentationMode
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage {
        parent.image = uiImage
      }
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {}
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    picker.sourceType = isCamera ? .camera : .photoLibrary
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
