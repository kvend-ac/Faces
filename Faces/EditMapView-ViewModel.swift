//
//  EditMapView-ViewModel.swift
//  Faces
//
//  Created by Сергей Прасолов on 13.10.2024.
//

import MapKit
import Foundation
import SwiftUI

extension EditMapView {
    
    @Observable
    class ViewModel {
        var face: Face
        private var updateCoordinate: (CLLocationCoordinate2D?) -> Void
        
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
        
        init(face: Face, updateCoordinate: @escaping (CLLocationCoordinate2D?) -> Void) {
            self.face = face
            self.updateCoordinate = updateCoordinate
        }
        
        func newPosition(coordinate: CLLocationCoordinate2D) {
            face.latitude = coordinate.latitude
            face.longtitude = coordinate.longitude
            updateCoordinate(face.coordinate)
        }
    }
    
}
