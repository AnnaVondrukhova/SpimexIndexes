//
//  JSONFileManager.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 15.03.2023.
//

import Foundation

class JSONFileManager {
    static func loadJSON<T: Decodable>(withFilename filename: String) throws -> T? {
        let path: URL?
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        path = urls.first
        
        if let url = path {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            
            let data = try Data(contentsOf: fileURL, options: [])
            
            let decoder = JSONDecoder()
//            return try? decoder.decode(T.self, from: data)
            let indexArray = try decoder.decode(T.self, from: data)
            return indexArray
        }
        return nil
    }
    
    @discardableResult
    static func saveJSON<T: Encodable>(jsonObject: T, toFilename filename: String, completion: ((Bool) -> Void)? = nil ) throws -> Bool {
        let path: URL?
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        path = urls.first
        
        if let url = path {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            
            do {
                
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(jsonObject)
                    
                try jsonData.write(to: fileURL, options: [])
                completion?(true)
                } catch {
                    print(error)
                    completion?(false)
                }
        }
        
        return false
    }
    
    static func testSave(indexes: [Index], toFilename filename: String) {
        let path: URL?
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        path = urls.first
        
        if let url = path {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            
            do {
                
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(indexes)
                    
                try jsonData.write(to: fileURL, options: [])
                } catch {
                    print(error)
                }
            
            do {
                    let data = try Data(contentsOf: fileURL, options: [])
                let decoder = JSONDecoder()
                let indexArray = try decoder.decode([Index].self, from: data)
                    print(indexArray) 
                } catch {
                    print(error)
                }
        }
    }
}
