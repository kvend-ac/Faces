//
//  FaceView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 13.10.2024.
//

import Foundation

extension FaceView {
    
    @Observable
    class ViewModel {
        
        var face: Face
        var onSave: (Face) -> Void
        var onDelete: (Face) -> Void
        
        var mapSheetView = false
        var selectedEditFace: Face?
        
        init(face: Face, onSave: @escaping (Face) -> Void, onDelete: @escaping (Face) -> Void) {
            self.face = face
            self.onSave = onSave
            self.onDelete = onDelete
        }
        
        func save(editedFace: Face) {
            face = editedFace
            onSave(editedFace)
        }
        
        func delete(deletingFace: Face) {
            onDelete(deletingFace)
        }
    }
    
}
