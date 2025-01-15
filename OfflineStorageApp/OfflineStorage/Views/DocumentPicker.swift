//
//  DocumentPicker.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI
import MobileCoreServices

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var isDocumentPickerPresented: Bool
    var onFilePicked: (URL) -> Void

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.onFilePicked(url)
                parent.isDocumentPickerPresented = false
            }
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.isDocumentPickerPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.data, .text, .pdf, .image])
        documentPicker.delegate = context.coordinator
        documentPicker.allowsMultipleSelection = false
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // No update needed for this simple case
    }
}
