//
//  EditFaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 27.08.2024.
//

import SwiftUI
import PhotosUI

struct EditFaceView: View {
    
    @Environment(\.dismiss) var dismiss
    var face: Face
    
    @State var name: String
    @State var description: String
    var onSave: (Face) -> Void
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var selectedImageData: Data?
    
    init(face: Face, onSave: @escaping (Face) -> Void) {
        self.face = face
        self.onSave = onSave
        
        _name = State(initialValue: face.name)
        _description = State(initialValue: face.description)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        face.photo
                            .resizable()
                            .scaledToFit()
                    }
                }
                VStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    TextField("Description", text: $description)
                        
    
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
                Spacer()
            }
            .ignoresSafeArea()
            .onChange(of: selectedItem) {
                loadNewPhoto()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        var newFace = face
                        newFace.id = UUID()
                        newFace.name = "DELETE"
                        newFace.description = ""
                        onSave(newFace)
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .padding(7)
                            .foregroundColor(.secondary)
                            .background(.thinMaterial)
                            .clipShape(.capsule)
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        var newFace = face
                        newFace.id = UUID()
                        newFace.name = name
                        newFace.description = description
                        if let selectedImageData {
                            newFace.photoData = selectedImageData
                        }
                        onSave(newFace)
                        dismiss()
                    } label: {
                        Text("Save")
                            .padding(10)
                            .foregroundColor(.secondary)
                            .background(.thinMaterial)
                            .clipShape(.capsule)
                    }
                }
            }
            Spacer()
        }
    }
    
    func loadNewPhoto() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            selectedImageData = imageData
            if let inputImage = UIImage(data: imageData) {
                selectedImage = Image(uiImage: inputImage)
            }
            
        }
    }
    
}

#Preview {
    EditFaceView(face: .example) { _ in }
}
