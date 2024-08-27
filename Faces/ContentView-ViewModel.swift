//
//  ContentView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 27.08.2024.
//

import CoreLocation
import Foundation
import PhotosUI
import SwiftUI

extension ContentView {
    
    @Observable
    class ViewModel {
        var selectedItem: PhotosPickerItem?
        
        private(set) var faces = [Face]()
        var selectedAddFace: Face?
        var selectedEditFace: Face?
        var selectedViewFace: Face?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedFaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                faces = try JSONDecoder().decode([Face].self, from: data)
            } catch {
                faces = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(faces)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        //заготовка
        func addFace(at face: Face) {
            faces.append(face)
            save()
        }
        
        func update(face: Face) {
            guard let selectedEditFace else { return }
            
            if let index = faces.firstIndex(of: selectedEditFace) {
                faces[index] = face
            }
            save()
        }
        
        func delete(face: Face) {
            guard let selectedEditFace else { return }
            
            if let index = faces.firstIndex(of: selectedEditFace) {
                faces.remove(at: index)
            }
            save()
        }
        
        func loadImage() {
            
            Task {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                selectedAddFace = Face(id: UUID(), photoData: imageData, name: "", description: "")
                selectedItem = nil
            }
            
        }
        
    }
    
    
}
