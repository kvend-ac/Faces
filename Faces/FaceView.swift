//
//  FaceView.swift
//  Faces
//
//  Created by Сергей Прасолов on 28.08.2024.
//

import SwiftUI

struct FaceView: View {
    @State var face: Face
    @Environment(\.dismiss) var dismiss
    
    @State private var mapSheetView = false
    
    var body: some View {
        ScrollView {
            face.photo
                .resizable()
                .scaledToFit()
            HStack {
                VStack(alignment: .leading) {
                    Text(face.name)
                        .font(.title)
                    Text(face.description)
                }
                .padding(5)
                .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top, -10)
                
                
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $mapSheetView) {
            MapView(face: face)
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .bold()
                        Text("Назад")
                    }
                    .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //вьюшка мапы
                    mapSheetView = true
                } label: {
                    Image(systemName: "map")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    FaceView(face: .example)
}
