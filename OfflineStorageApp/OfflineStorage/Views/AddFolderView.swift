//
//  AddFolderView.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI

struct AddFolderView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedColor: Color = .green
    @FocusState private var isTextFieldFocused: Bool

    private var isFormValid: Bool{
        !name.isEmpty
    }
    let onSave : (String, UIColor) -> Void

    var body: some View {
        VStack{
            VStack{
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(selectedColor)
                    .font(.system(size: 100))
                TextField("Folder Name", text: $name)
                    .focused($isTextFieldFocused)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding(10)
            }.padding(30)
                .onTapGesture {
                    isTextFieldFocused = true
                }
                .clipShape(RoundedRectangle(cornerRadius: 10.0,style: .continuous))

            ColorPickerView(selectedColor: $selectedColor)
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("New Folder")
                        .font(.headline)
                }
                ToolbarItem(placement: .topBarLeading){
                    Button("Close"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        onSave(name, UIColor(selectedColor))
                        dismiss()
                    }.disabled(!isFormValid)
                }

            }
    }
}

#Preview {
    NavigationView{
        AddFolderView(onSave:{ (_,_) in })
    }
}
