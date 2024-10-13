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
    
    init(face: Face, onSave: @escaping (Face) -> Void, onDelete: @escaping (Face) -> Void) {
        self.face = face
        self.viewModel = ViewModel(face: face, onSave: onSave, onDelete: onDelete)
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
                        viewModel.delete()
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
                        viewModel.save()
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
