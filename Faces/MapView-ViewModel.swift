//
//  MapView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 14.10.2024.
//

import Foundation
import MapKit
import SwiftUI

extension MapView {
    
    @Observable
    class ViewModel {
        
        var face: Face
        
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
        
        init(face: Face) {
            self.face = face
        }
        
    }
    
}
