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
    
    @State private var faces = [Face]()
    @State private var selectedFace: Face?
    @State private var selectedData: Data?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(faces) { face in
                        HStack(alignment: .center) {
                            face.photo
                                .resizable()
                                .scaledToFit()
                                .clipShape(.circle)
                                .frame(width: 100, height: 100)
                            VStack(alignment: .leading) {
                                Text(face.name)
                                    .font(.title)
                                Text(face.description)
                                    .foregroundStyle(.secondary)
//                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
                .sheet(item: $selectedFace) { face in
                    AddFaceView(face: face) { newFace in
                        faces.append(newFace)
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
        .preferredColorScheme(.light)
    }
    
    func loadImage() {
        
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
//            faces.append(Face(id: UUID(), photoData: imageData, name: "New photo", description: "desc"))
            selectedFace = Face(id: UUID(), photoData: imageData, name: "", description: "")
            selectedItem = nil
        }
        
    }
}

#Preview {
    ContentView()
}
