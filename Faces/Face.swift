//
//  Face.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import Foundation
import SwiftUI
import MapKit

struct Face: Codable, Equatable, Identifiable, Comparable, Hashable {
    
    var id: UUID
    var photoData: Data?
    var name: String
    var description: String
    
    var latitude: Double?
    var longtitude: Double?
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude else { return nil }
        guard let longtitude else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    
    var photo: Image {
        
        guard let photoData else { return Image(systemName: "photo.artframe") }
        
        if let inputImage = UIImage(data: photoData) {
            return Image(uiImage: inputImage)
        } else {
            return Image(systemName: "photo.artframe")
        }
        
    }
    
    #if DEBUG
    static let example = Face(id: UUID(), name: "Alice", description: "Person from a book", latitude: 51, longtitude: 9)
    #endif
    //Этот метод определяет по какому свойству будут проверяться на равенство два экземпляра структуры
    static func ==(lhs: Face, rhs: Face) -> Bool {
        lhs.id == rhs.id
    }
    //Этот метод позволяет использовать сортировку по умолчанию, например как faces.sorted()
    static func < (lhs: Face, rhs: Face) -> Bool {
        lhs.name < rhs.name
    }
    
}
