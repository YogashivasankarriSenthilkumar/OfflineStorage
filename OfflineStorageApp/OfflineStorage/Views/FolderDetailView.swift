//
//  FolderDetailView.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI
import UIKit

struct FolderDetailView: View {
    let folder: FolderList
    @State private var isImagePickerPresented = false
    @State private var isDocumentPickerPresented = false
    @State private var fileUploadSuccess: Bool? = nil
    @State private var isUploading = false
    @FetchRequest var uploadedFiles: FetchedResults<FileUpload>

    init(folder: FolderList) {
        self.folder = folder
        _uploadedFiles = FetchRequest(
            entity: FileUpload.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \FileUpload.fileName, ascending: true)],
            predicate: NSPredicate(format: "folder == %@", folder)
        )
    }

    var body: some View {
        VStack(spacing: 20) {

            if let success = fileUploadSuccess {
                Text(success ? "File uploaded successfully!" : "Upload failed.")
                    .font(.headline)
                    .foregroundColor(success ? .green : .red)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(success ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .cornerRadius(8)
            }

            Spacer(minLength: 20)

            HStack(spacing: 20) {
                Button("Upload Image") {
                    isImagePickerPresented = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(isUploading)

                Button("Upload Document") {
                    isDocumentPickerPresented = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(isUploading)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(uploadedFiles, id: \.self) { file in
                        FileRow(file: file)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                    }
                }
            }

            Spacer()
        }
        .navigationTitle(folder.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(isImagePickerPresented: $isImagePickerPresented) { url in
                saveFileToCoreData(url: url, folder: folder)
            }
        }
        .sheet(isPresented: $isDocumentPickerPresented) {
            DocumentPicker(isDocumentPickerPresented: $isDocumentPickerPresented) { url in
                saveFileToCoreData(url: url, folder: folder)
            }
        }
        .overlay(
            Group {
                if isUploading {
                    ProgressView("Uploading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding(40)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
            }
        )
    }

    private func saveFileToCoreData(url: URL, folder: FolderList) {
        isUploading = true
        do {
            try FolderService.saveFile(url.lastPathComponent, url.absoluteString, to: folder)
            fileUploadSuccess = true
        } catch {
            fileUploadSuccess = false
        }
        isUploading = false
    }
}

struct FileRow: View {
    let file: FileUpload

    var body: some View {
        HStack {
            Text(file.fileName)
                .font(.body)
                .lineLimit(1)
            Spacer()

            if let fileUrl = URL(string: file.fileUrl) {
                if fileUrl.pathExtension.lowercased() == "jpg" || fileUrl.pathExtension.lowercased() == "png" {
                    if let image = UIImage(contentsOfFile: fileUrl.path) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                // Handle image preview (open large image)
                            }
                    } else {
                        Text("Image not available")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                } else {
                    FileTypeIcon(fileExtension: fileUrl.pathExtension)
                }
            } else {
                Text("Invalid URL")
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}

struct FileTypeIcon: View {
    let fileExtension: String

    var body: some View {
        Image(systemName: fileExtension.lowercased() == "pdf" ? "doc.text.fill" : "doc.fill")
            .font(.system(size: 20))
            .foregroundColor(.gray)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    FolderDetailView(folder: FolderList())
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
