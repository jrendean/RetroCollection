//
//  DataManager.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import Foundation

// https://app.pluralsight.com/library/courses/swiftui-building-ios-user-interfaces/table-of-contents


struct DataManager {
    func load(completion: @escaping ([RetroCollectionItem]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            // Copy the projects.json file to the user's documents folder if it's not already there
            // (you and I should never save files back to the application bundle directory, so make an initial copy)
            if FileManager.default.fileExists(atPath: Self.fileURL.path) == false {
                let bundledProjectsURL = Bundle.main.url(forResource: "collection", withExtension: "json")!
                try! FileManager.default.copyItem(at: bundledProjectsURL, to: Self.fileURL)
            }
            
            //debugging to find the where the file was copied to
            print(Self.fileURL.path)
            
            // Attempt to load the contents of the projects.json file that's in the user's documents folder
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                return
            }
            
            // Prepare a JSONDecoder, ensuring that it can successfully decode dates into the Swift Date type
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            // Attempt to decode the JSON document into an array of RenovationProject instances
            guard let retroCollections = try? decoder.decode([RetroCollectionItem].self, from: data) else {
                fatalError("Can't decode saved renovation project data.")
            }
            
            // Pass the array of RenovationProject instances back to the caller through the completion handler that is passed in
            DispatchQueue.main.async {
                completion(retroCollections)
            }
        }
    }
    
    func save(retroCollectionItems: [RetroCollectionItem]) {
        DispatchQueue.global(qos: .background).async {
            // Prepare a JSONEncoder, ensuring that it can successfully re-encode dates from the Swift Date type into text within the resulting JSON representation
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            encoder.outputFormatting = .prettyPrinted
            
            // Attempt to encode the array of RenovationProject instances into a JSON document
            guard let renovationProjectsData = try? encoder.encode(retroCollectionItems) else { fatalError("Error encoding data") }
            do {
                // Write the encoded JSON document to the user's document's folder
                let outfile = Self.fileURL
                try renovationProjectsData.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
    
    // MARK: Helper functions
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
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("collection.json")
    }
}

