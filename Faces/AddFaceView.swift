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
    let locationFetcher = LocationFetcher()
    
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
                    TextField("Имя", text: $name, axis: .vertical)
                    TextField("Дополнительная информация", text: $description, axis: .vertical)
//                    TextEditor(text: $description)
//                        .clipShape(.rect(cornerRadius: 5))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(.separator.opacity(0.5))
//                        ) //запасной вариант, менее красивый
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
                Spacer()
            }
            .ignoresSafeArea()
            .onAppear {
                locationFetcher.start()
            }
            .toolbar {
                Button {
                    var newFace = face
                    if let location = locationFetcher.lastKnownLocation {
                        newFace.longtitude = location.longitude
                        newFace.latitude = location.latitude
                    }
                    newFace.name = name
                    newFace.description = description
                    onSave(newFace)
                    dismiss()
                } label: {
                    Text("Сохранить")
                        .padding(10)
                        .foregroundColor(.secondary)
                        .background(.thinMaterial)
                        .clipShape(.capsule)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    AddFaceView(face: .example) { _ in }
}
