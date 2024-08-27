//
//  ContentView.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import SwiftUI
import PhotosUI

struct FaceView: View {
    
    @State var face: Face
    
    var body: some View {
        Text("View for \(face.name)")
    }
}

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.faces.sorted()) { face in
                        VStack {
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
                                }
                                Spacer()
                            }
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondary)
                        )
                        .padding(.horizontal, 5)
                        .padding(.vertical, -1)
                        .onLongPressGesture {
                            //вьюшка изменения текста или удаления
                        }
                    }
                }
                .sheet(item: $viewModel.selectedFace) { face in
                    AddFaceView(face: face) { newFace in
                        viewModel.faces.append(newFace)
                    }
                }
                .onChange(of: viewModel.selectedItem) {
                    loadImage()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        PhotosPicker("Select photo", selection: $viewModel.selectedItem)
                    }
                }
            }
            .navigationTitle("Faces")
        }
        .preferredColorScheme(.light)
    }
    
    func loadImage() {
        
        Task {
            guard let imageData = try await viewModel.selectedItem?.loadTransferable(type: Data.self) else { return }
//            faces.append(Face(id: UUID(), photoData: imageData, name: "New photo", description: "desc"))
            viewModel.selectedFace = Face(id: UUID(), photoData: imageData, name: "", description: "")
            viewModel.selectedItem = nil
        }
        
    }
}

#Preview {
    ContentView()
}
