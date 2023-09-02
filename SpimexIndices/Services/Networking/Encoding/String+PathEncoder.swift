//
//  String+PathEncoder.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

extension String {
    func pathEncode(with parameters: [String: Any]) -> Self {
        var text = self
        parameters.forEach { (key, value) in
            text = text.replacingOccurrences(of: "{\(key)}", with: String(describing: value))
        }
        
        return text
    }
}
