//
//  Sheet.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 30.03.2023.
//

import Foundation

struct Sheet: Codable {
    var sheetId: String
    var sheetName: String
    var groups: [Group]
    var sortIndex: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case sheetId = "sheetId"
        case sheetName = "sheetName"
        case groups = "groups"
    }
}

extension Sheet: Hashable {
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs.sheetId == rhs.sheetId
    }
}
