//
//  EditMapView.swift
//  Faces
//
//  Created by Сергей Прасолов on 13.10.2024.
//

import MapKit
import SwiftUI

struct EditMapView: View {
    
    @State var face: Face
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(face: Face, updateCoordinate: @escaping (CLLocationCoordinate2D?) -> Void) {
        self.face = face
        self.viewModel = ViewModel(face: face, updateCoordinate: updateCoordinate)
    }
    
    var body: some View {
        ZStack {
            MapReader { proxy in
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
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.newPosition(coordinate: coordinate)
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
    EditMapView(face: .example) { _ in }
}
