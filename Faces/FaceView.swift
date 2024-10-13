//
//  FaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 28.08.2024.
//

import SwiftUI

struct FaceView: View {
    
    @State var face: Face
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(face: Face, onSave: @escaping (Face) -> Void, onDelete: @escaping (Face) -> Void) {
        self.face = face
        self.viewModel = ViewModel(face: face, onSave: onSave, onDelete: onDelete)
    }
    
    var body: some View {
        ScrollView {
            viewModel.face.photo
                .resizable()
                .scaledToFit()
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.face.name)
                        .font(.title)
                    Text(viewModel.face.description)
                    
                }
                .padding(5)
                .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top, -10)
            if viewModel.face.coordinate != nil {
                Button {
                    viewModel.mapSheetView = true
                } label: {
                    HStack {
                        Image(systemName: "map")
                        Text("Map location")
                    }
                    .padding(10)
                    .foregroundColor(.primary)
                    .background(.thinMaterial)
                    .clipShape(.capsule)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .sheet(item: $viewModel.selectedEditFace) { face in
            EditFaceView(face: face) { editedFace in
                viewModel.save(editedFace: editedFace)
            } onDelete: { deletingFace in
                viewModel.delete(deletingFace: deletingFace)
                dismiss()
            }
        }
        .sheet(isPresented: $viewModel.mapSheetView) {
            MapView(face: viewModel.face)
                .presentationDetents([.medium, .large])
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                //Back Button
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .bold()
                        Text("Back")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    viewModel.selectedEditFace = viewModel.face
                }
            }
        }
        .foregroundColor(.primary)
    }
}

#Preview {
    FaceView(face: .example) { _ in } onDelete: { _ in }
}
