//
//  User.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 16.03.2023.
//

import Foundation

struct User: Codable {
    var sheets: [Sheet]
    var selectedSheetId: String
    
    enum CodingKeys: String, CodingKey {
        case sheets = "sheets"
        case selectedSheetId = "selectedSheetId"
    }
}
