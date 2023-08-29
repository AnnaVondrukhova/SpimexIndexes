//
//  Group.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 16.03.2023.
//

import Foundation

struct Group: Codable {
    var groupId: String
    var groupName: String
    var section: SectionName
    var products: [String]
    var sortIndex: Int = 0
    var title: TitleSettings = .productCode
    var subtitle: SubtitleSettings = .placeName
    
    enum CodingKeys: String, CodingKey {
        case groupId = "groupId"
        case groupName = "groupName"
        case section = "section"
        case products = "products"
        case title = "title"
        case subtitle = "subtitle"
    }
}

extension Group: Hashable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.groupId == rhs.groupId
    }
}
