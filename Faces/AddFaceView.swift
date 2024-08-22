//
//  AddFaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import SwiftUI

struct AddFaceView: View {
    
    @Environment(\.dismiss) var dismiss
    var face: Face
    
    @State var name: String
    @State var description: String
    var onSave: (Face) -> Void
    
    init(face: Face, onSave: @escaping (Face) -> Void) {
        self.face = face
        self.onSave = onSave
        
        _name = State(initialValue: face.name)
        _description = State(initialValue: face.description)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
//                Image(systemName: "photo.artframe")
                face.photo
                    .resizable()
                    .scaledToFit()
                VStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    TextField("Description", text: $description)
                        
    
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
                Spacer()
            }
            .ignoresSafeArea()
            .toolbar {
                Button("Save") {
                    var newLocation = face
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
            Spacer()
        }
    }
}

//#Preview {
//    AddFaceView(face: .example) { _ in }
//}
