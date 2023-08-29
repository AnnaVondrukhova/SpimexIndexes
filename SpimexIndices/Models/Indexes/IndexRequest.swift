//
//  IndexRequest.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 10.04.2023.
//

import Foundation

struct IndexRequest: Codable {
    var section: String
    var indexCode: String
    var dateFrom: String?
    var dateTo: String?
    
    enum CodingKeys: String, CodingKey{
        case section = "section"
        case indexCode = "index_code"
        case dateFrom = "dateFrom"
        case dateTo = "dateTo"
    }
    
    init(section: SectionName, indexCode: String) {
        self.section = section.rawValue
        self.indexCode = indexCode
    }
}
