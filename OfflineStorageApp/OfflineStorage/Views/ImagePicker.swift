//
//  ImagePicker.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isImagePickerPresented: Bool
    var onImagePicked: (URL) -> Void

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let imageURL = info[.imageURL] as? URL {
                parent.onImagePicked(imageURL)
                parent.isImagePickerPresented = false
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isImagePickerPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        return imagePickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}
