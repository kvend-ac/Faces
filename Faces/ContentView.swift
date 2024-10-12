//
//  ContentView.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            Form {
                List(viewModel.faces.sorted()) { face in
                    NavigationLink {
                        FaceView(face: face)
                    } label: {
                        HStack {
                            face.photo
                                .resizable()
                                .scaledToFill()
                                .clipShape(.circle)
                                .frame(width: 70, height: 70)
                            
                            VStack(alignment: .leading) {
                                Text(face.name)
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                Text(face.description)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .contextMenu {
                        Button("Edit", systemImage: "square.and.pencil") {
                            viewModel.selectedEditFace = face
                        }
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            viewModel.delete(face: face)
                        }
                    }
                }
                .sheet(item: $viewModel.selectedAddFace) { face in
                    AddFaceView(face: face) { newFace in
                        viewModel.addFace(at: newFace)
                    }
                }
                .sheet(item: $viewModel.selectedEditFace) { face in
                    EditFaceView(face: face) { editedFace in
                        if editedFace.name == "DELETE" {
                            viewModel.delete(face: editedFace)
                        } else {
                            viewModel.update(face: editedFace)
                        }
                    }
                }
                .onChange(of: viewModel.selectedItem) {
                    viewModel.loadImage()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                        Image(systemName: "plus.app")
                            .resizable()
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Faces")
        }
        .preferredColorScheme(.light)
    }
    

}

#Preview {
    ContentView()
}
