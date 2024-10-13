//
//  AddFaceView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 13.10.2024.
//

import Foundation

extension AddFaceView {
    
    @Observable
    class ViewModel {
        
        var face: Face
        var onSave: (Face) -> Void
        
        var name: String
        var description: String
        let locationFetcher = LocationFetcher()
        
        init(face: Face, onSave: @escaping (Face) -> Void) {
            self.face = face
            self.onSave = onSave
            self.name = face.name
            self.description = face.description
        }
        
        func save() {
            var newFace = face
            if let location = locationFetcher.lastKnownLocation {
                newFace.longtitude = location.longitude
                newFace.latitude = location.latitude
            }
            newFace.name = name
            newFace.description = description
            onSave(newFace)
        }
        
    }
    
}
