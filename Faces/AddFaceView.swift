//
//  AddFaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import SwiftUI

struct AddFaceView: View {
    
    var face: Face
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(face: Face, onSave: @escaping (Face) -> Void) {
        self.face = face
        self.viewModel = ViewModel(face: face, onSave: onSave)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                face.photo
                    .resizable()
                    .scaledToFit()
                VStack {
                    TextField("Name", text: $viewModel.name, axis: .vertical)
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
                Spacer()
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.locationFetcher.start()
            }
            .toolbar {
                Button {
                    viewModel.save()
                    dismiss()
                } label: {
                    Text("Add")
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
