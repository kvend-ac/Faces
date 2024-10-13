//
//  EditFaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 27.08.2024.
//

import SwiftUI
import PhotosUI

struct EditFaceView: View {
    
    var face: Face
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Face) -> Void
    var onDelete: (Face) -> Void
    
    init(face: Face, onSave: @escaping (Face) -> Void, onDelete: @escaping (Face) -> Void) {
        self.face = face
        self.onSave = onSave
        self.onDelete = onDelete
        self.viewModel = ViewModel(face: face)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                    if let selectedImage = viewModel.selectedImage {
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
                    TextField("Name", text: $viewModel.name, axis: .horizontal)
                    TextField("Description", text: $viewModel.description, axis: .horizontal)
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
                Spacer()
            }
            .ignoresSafeArea()
            .onChange(of: viewModel.selectedItem) {
                viewModel.loadNewPhoto()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        onDelete(face)
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
                        newFace.name = viewModel.name
                        newFace.description = viewModel.description
                        if let selectedImageData = viewModel.selectedImageData {
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
    
}

#Preview {
    EditFaceView(face: .example) { _ in } onDelete: { _ in }
}
