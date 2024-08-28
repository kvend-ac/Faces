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
    
    let columns = [
        GridItem(.adaptive(minimum: 600, maximum: CGFloat(Int.max)))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.faces.sorted()) { face in
                        NavigationLink {
                            FaceView(face: face)
                        } label: {
                            VStack {
                                HStack(alignment: .center) {
                                    face.photo
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(.circle)
                                        .frame(width: 70, height: 70)
                                        .padding(7)
                                        .onLongPressGesture {
                                            //вьюшка изменения текста или удаления
                                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                            impactMed.impactOccurred()
                                            viewModel.selectedEditFace = face
                                        }
                                    VStack(alignment: .leading) {
                                        Text(face.name)
                                            .font(.title)
                                            .foregroundStyle(.black)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        Text(face.description)
                                            .foregroundStyle(.black.opacity(0.5))
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                }
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black.opacity(0.5))
                            )
                            .padding(.horizontal, 5)
                            .padding(.vertical, -1)
                        }
                    }
                }
                .padding([.vertical, .bottom])
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
            .alert("", isPresented: $viewModel.showingAlertInfo) {

            } message: {
                Text("Для того, что бы редактировать или удалить запись - удержирайте миниатюру изображения")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                        Image(systemName: "plus.app")
                            .resizable()
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showingAlertInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.light)
    }
    

}

#Preview {
    ContentView()
}
