//
//  Photo.swift
//  RetroCollection
//
//  Created by JR Endean on 3/28/22.
//

import Foundation
import SwiftUI

struct Photo: Codable, Identifiable {
    var id = UUID()
    var defaultImage: Bool = false
    
    var image: ImageWrapper
    
    var saved: Bool = true
    var shouldDelete: Bool = false
    var shouldDefault: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, defaultImage, image
    }
}

//https://github.com/hyperoslo/Cache/blob/master/Source/Shared/Library/ImageWrapper.swift
struct ImageWrapper: Codable {
    
    var imageData: Data
    
    private enum CodingKeys: String, CodingKey {
        case imageData
    }
    
    public init(image: UIImage) {
        self.imageData = image.pngData()!
      }

    
    /*
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let data = try container.decode(Data.self, forKey: CodingKeys.imageData)
        //guard let image = UIImage(data: data) else {
        //  //throw StorageError.decodingFailed
        //    fatalError("blah")
        //}
        self.imageData = data
     }
     
     public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        guard let data = image.pngData() else {
            //throw StorageError.encodingFailed
            fatalError("blah blah")
        }

        try container.encode(data, forKey: CodingKeys.imageData)
    }
    */
}
