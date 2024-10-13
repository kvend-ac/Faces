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
                if face.coordinate != nil {
                    Button {
                        //MapView
                        viewModel.mapSheetView = true
                    } label: {
                        Image(systemName: "map")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    viewModel.selectedEditFace = face
                }
            }
        }
        .foregroundColor(.primary)
    }
}

#Preview {
    FaceView(face: .example) {_ in} onDelete: {_ in}
}
