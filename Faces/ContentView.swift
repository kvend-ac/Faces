//
//  ContentView.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import SwiftUI
import PhotosUI

//Надо оформить как NavigationLink для просмотра вьюшки Face, а по долгому нажатию вызывать sheet, но уже другой, с просмотром соответственно для изменения Face, возможно стиль не sheet, а другой например на fullScreenCover, а может и оставить как sheet, только для другой переменной, котору будем тригерить в долгом нажатии


//временная вьюшка
struct FaceView: View {
    
    @State var face: Face
    
    var body: some View {
        face.photo
            .resizable()
            .scaledToFit()
        Text(face.name)
        Spacer()
    }
}

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
                                        Text(face.description)
                                            .foregroundStyle(.black.opacity(0.5))
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                        Image(systemName: "plus.app")
                            .resizable()
                            .font(.title)
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
