//
//  EditFaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 27.08.2024.
//

import SwiftUI

struct EditFaceView: View {
    
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        var newFace = face
                        newFace.id = UUID()
                        newFace.name = "DELETE"
                        newFace.description = ""
                        onSave(newFace)
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") {
                        var newFace = face
                        newFace.id = UUID()
                        newFace.name = name
                        newFace.description = description
                        onSave(newFace)
                        dismiss()
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    EditFaceView(face: .example) { _ in }
}
