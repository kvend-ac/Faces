//
//  ContentView.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var image: Image?
    
    @State private var faces = [Face]()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(faces) { face in
                        face.photo
                            .resizable()
                            .scaledToFit()
                        Text(face.name)
                    }
                }
                .onChange(of: selectedItem) {
                    loadImage()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        PhotosPicker("Select photo", selection: $selectedItem)
                    }
                }
            }
        }
    }
    
    func loadImage() {
        
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            faces.append(Face(id: UUID(), photoData: imageData, name: "New photo", description: "desc"))
        }
        
    }
}

#Preview {
    ContentView()
}
