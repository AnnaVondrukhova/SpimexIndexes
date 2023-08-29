//
//  Encodable+JSON.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 15.03.2023.
//

import Foundation

extension Encodable {
    func toData() -> Data? {
        let jsonEncoder = JSONEncoder()
//        jsonEncoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try jsonEncoder.encode(self)
            return jsonData
        } catch {
            return nil
        }
    }
    
    func toJsonString() -> String? {
        guard let jsonData = self.toData() else { return nil }
        
        return String(data: jsonData, encoding: .utf8)
    }
    
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}
