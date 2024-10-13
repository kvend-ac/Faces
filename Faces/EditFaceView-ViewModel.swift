//
//  EditFaceView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 13.10.2024.
//

import Foundation
import SwiftUI
import PhotosUI

extension EditFaceView {
    
    @Observable
    class ViewModel {
        
        private var face: Face
        private var onSave: (Face) -> Void
        private var onDelete: (Face) -> Void
        
        var name: String
        var description: String
        
        var selectedItem: PhotosPickerItem?
        var selectedImage: Image?
        private var selectedImageData: Data?
        
        init(face: Face, onSave: @escaping (Face) -> Void, onDelete: @escaping (Face) -> Void) {
            self.face = face
            self.onSave = onSave
            self.onDelete = onDelete
            self.name = face.name
            self.description = face.description
        }
        
        func save() {
            var newFace = face
            newFace.id = UUID()
            newFace.name = name
            newFace.description = description
            if let selectedImageData = selectedImageData {
                newFace.photoData = selectedImageData
            }
            onSave(newFace)
        }
        
        func delete() {
            onDelete(face)
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
    
}
