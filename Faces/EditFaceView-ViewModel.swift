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
        
        var face: Face
        
        var name: String
        var description: String
        
        var selectedItem: PhotosPickerItem?
        var selectedImage: Image?
        var selectedImageData: Data?
        
        init(face: Face) {
            self.face = face
            self.name = face.name
            self.description = face.description
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
