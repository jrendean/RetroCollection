//
//  DataManager.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import Foundation
import SwiftUI
// https://app.pluralsight.com/library/courses/swiftui-building-ios-user-interfaces/table-of-contents


struct DataManager {
    
    static var computersFileURL: URL = documentsFolder.appendingPathComponent("computers.json")
    static var componentsFileURL: URL = documentsFolder.appendingPathComponent("components.json")
    static var gamingFileURL: URL = documentsFolder.appendingPathComponent("gaming.json")
    
    static func loadComputersCollection(completion: @escaping ([ComputerCollectionItem]) -> Void) {
        DispatchQueue.global(qos: .background).async {
                        
            let collection: [ComputerCollectionItem] = loadData(file: self.computersFileURL)

            DispatchQueue.main.async {
                completion(collection)
            }
        }
    }
    
    static func loadComponentsCollection(completion: @escaping ([ComponentCollectionItem]) -> Void) {
        DispatchQueue.global(qos: .background).async {
                        
            let collection: [ComponentCollectionItem] = loadData(file: self.componentsFileURL)

            DispatchQueue.main.async {
                completion(collection)
            }
        }
    }
    
    static func loadGamingCollection(completion: @escaping ([GamingCollectionItem]) -> Void) {
        DispatchQueue.global(qos: .background).async {
                        
            let collection: [GamingCollectionItem] = loadData(file: self.gamingFileURL)

            DispatchQueue.main.async {
                completion(collection)
            }
        }
    }
    
    private static func loadData<T: Codable>(file: URL) -> [T] {
        // Copy the projects.json file to the user's documents folder if it's not already there
        // (you and I should never save files back to the application bundle directory, so make an initial copy)
        if FileManager.default.fileExists(atPath: file.path) == false {
            let bundledProjectsURL = Bundle.main.url(forResource: "collection", withExtension: "json")!
            try! FileManager.default.copyItem(at: bundledProjectsURL, to: file)
        }
        
        //debugging to find the where the file was copied to
        print(file.path)
        
        // Attempt to load the contents of the projects.json file that's in the user's documents folder
        guard let data = try? Data(contentsOf: file) else {
            return [T]()
        }
        
        // Prepare a JSONDecoder, ensuring that it can successfully decode dates into the Swift Date type
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        // Attempt to decode the JSON document into an array of RenovationProject instances
        guard var collection = try? decoder.decode([T].self, from: data) else {
            #if DEBUG
            try! FileManager.default.removeItem(at: file)
            #endif
            fatalError("Can't decode saved collection project data.")
        }
        
        // to remove photos
        /*
        for i in retroCollections.indices {
            retroCollections[i].photos.removeAll()
        }
        self.save(retroCollectionItems: retroCollections)
        */
        
        return collection
    }
    
    
    static func saveComputersCollection(computerCollectionItems: [ComputerCollectionItem]) {
        DispatchQueue.global(qos: .background).async {
            saveData(file: self.computersFileURL, data: computerCollectionItems)
        }
    }
    
    static func saveComponentsCollection(componentsCollectionItems: [ComponentCollectionItem]) {
        DispatchQueue.global(qos: .background).async {
            saveData(file: self.componentsFileURL, data: componentsCollectionItems)
        }
    }
    
    static func saveGamingCollection(gamingCollectionItems: [GamingCollectionItem]) {
        DispatchQueue.global(qos: .background).async {
            saveData(file: self.gamingFileURL, data: gamingCollectionItems)
        }
    }
    
    private static func saveData<T: Codable>(file: URL, data: [T]) {
        // Prepare a JSONEncoder, ensuring that it can successfully re-encode dates from the Swift Date type into text within the resulting JSON representation
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        // Attempt to encode the array of RenovationProject instances into a JSON document
        guard let encodedData = try? encoder.encode(data) else { fatalError("Error encoding data") }
        do {
            // Write the encoded JSON document to the user's document's folder
            try encodedData.write(to: file)
        } catch {
            fatalError("Can't write to file")
        }
    }
    
    /*
    static func loadImage111(filename: String) -> UIImage {
        //DispatchQueue.global(qos: .background).async {
        let imageFilename = documentsFolder.appendingPathComponent(filename)

        
        
        print(imageFilename.path)
        /*
        do {
            for url in try FileManager.default.contentsOfDirectory(atPath: documentsFolder.path) {
                print(url)
            }
        } catch {
            
        }
        */
        
        
        if FileManager.default.fileExists(atPath: imageFilename.path) == false {
            fatalError("Cannot find file")
        }
        
        guard let data = try? Data(contentsOf: imageFilename) else {
            fatalError("Cannot create Data?")
        }
        
        guard let image = UIImage(data: data) else {
            fatalError("Cannot load file data in to UIImage")
        }
        
        return image
            //DispatchQueue.main.async {
            //    completion(image)
            //}
        //}
    }
    
    static func saveImage111(filename: String, image: UIImage) {
        //DispatchQueue.global(qos: .background).async {
        do {
            let imageFilename = documentsFolder.appendingPathComponent(filename)
            
            try image.pngData()!.write(to: imageFilename)
            
            //return imageFilename
            
        } catch {
            fatalError("Can't write to file")
        }
        //}
    }
    
    static func deleteImage111(filename: String) {
        let imageFilename = documentsFolder.appendingPathComponent(filename)
        
        do {
            try FileManager.default.removeItem(at: imageFilename)
        } catch {
            fatalError("Cannot delete image")
        }
    }
    */
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    
}

