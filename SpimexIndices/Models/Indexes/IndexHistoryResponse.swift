//
//  IndexHistoryResponse.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 10.04.2023.
//

import Foundation

struct IndexHistoryResponse: Codable {
    var count: Int?
    var page: Int?
    var pageCount: Int?
    var data: [IndexInfo]?
}
