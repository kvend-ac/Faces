//
//  Face.swift
//  Faces
//
//  Created by Сергей Прасолов on 22.08.2024.
//

import Foundation
import SwiftUI

struct Face: Codable, Equatable, Identifiable, Comparable, Hashable {
    
    
    let id: UUID
    var photoData: Data?
    var name: String
    var description: String
    
    var photo: Image {
        if let inputImage = UIImage(data: photoData!) {
            return Image(uiImage: inputImage)
        } else {
            return Image(systemName: "photo.artframe")
        }
    }
    
    #if DEBUG
    static let example = Face(id: UUID(), name: "Alice", description: "Person from a book")
    #endif
    
    static func ==(lhs: Face, rhs: Face) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Face, rhs: Face) -> Bool {
        lhs.name < rhs.name
    }
    
}
