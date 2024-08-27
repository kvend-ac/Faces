//
//  ContentView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 27.08.2024.
//

import Foundation
import PhotosUI
import SwiftUI

extension ContentView {
    
    @Observable
    class ViewModel {
        var selectedItem: PhotosPickerItem?
        var faces = [Face]()
        var selectedFace: Face?
        var selectedEditFace: Face?
        
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
        func addFace() {
            
        }
        
    }
    
    
}
