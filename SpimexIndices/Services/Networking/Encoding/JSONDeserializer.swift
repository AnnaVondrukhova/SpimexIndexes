//
//  JSONDeserializer.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

class JSONDeserializer {
    func decode<T: Decodable>(data: Data?, completion: @escaping (T?) -> ()) {
        guard let data = data else {
            print("Deserializer failed: Data is Empty")
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(T.self, from: data)
            completion(result)
        } catch let jsonErr {
            print("Deserializer failed: decode error \n \(jsonErr)")
            completion(nil)
        }
    }
}
