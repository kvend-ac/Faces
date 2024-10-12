//
//  MapView.swift
//  Faces
//
//  Created by Сергей Прасолов on 29.08.2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    var startPosition: MapCameraPosition {
        guard let latitude = face.latitude else { return MapCameraPosition.automatic }
        guard let longtitude = face.longtitude else { return MapCameraPosition.automatic }
        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longtitude),
                span: MKCoordinateSpan(latitudeDelta: 0.200, longitudeDelta: 0.200)
            )
        )
    }
    
    @State var face: Face
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Map(initialPosition: startPosition) {
                
                if let coordinate = face.coordinate {
                    Annotation(face.name, coordinate: coordinate) {
                        face.photo
                            .resizable()
                            .scaledToFill()
                            .frame(width: 44, height: 44)
                            .clipShape(.circle)
                            .padding(3)
                            .background(.black)
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
