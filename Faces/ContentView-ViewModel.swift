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
    }
    
}
