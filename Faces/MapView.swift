//
//  MapView.swift
//  Faces
//
//  Created by Сергей Прасолов on 29.08.2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @State var face: Face
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(face: Face) {
        self.face = face
        self.viewModel = ViewModel(face: face)
    }
    
    var body: some View {
        ZStack {
            Map(initialPosition: viewModel.startPosition) {
                
                if let coordinate = viewModel.face.coordinate {
                    Annotation(viewModel.face.name, coordinate: coordinate) {
                        viewModel.face.photo
                            .resizable()
                            .scaledToFill()
                            .frame(width: 44, height: 44)
                            .clipShape(.circle)
                            .padding(3)
                            .background(.primary)
                            .clipShape(.circle)
                    }
                }
                
            }
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding(10)
                            .font(.title2.bold())
                            .foregroundColor(.secondary)
                            .background(.thinMaterial)
                            .clipShape(.circle)
                    }
                    Spacer()
                }
                .padding(5)
                Spacer()
            }
        }
    }
}

#Preview {
    MapView(face: .example)
}
