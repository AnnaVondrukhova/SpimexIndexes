//
//  IndexInfo.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 15.03.2023.
//

import Foundation

struct IndexInfo: Codable {
    
    let indexDate: String
    let indexCode: String
    let indexType: String?
    let indexPlace: String?
    let indexProduct: String?
    let indexValue: Double?
    let indexDiff: Double?
    let baseVolume: Int?
    let baseAmount: Int?
    let baseTrades: Int?
    let calcDate: String?
    let calcType: String?
    
    enum CodingKeys: String, CodingKey{
        case indexDate = "index_date"
        case indexCode = "index_code"
        case indexType = "index_type"
        case indexPlace = "index_place"
        case indexProduct = "index_product"
        case indexValue = "index_value"
        case indexDiff = "index_diff"
        case baseVolume = "base_volume"
        case baseAmount = "base_amount"
        case baseTrades = "base_trades"
        case calcDate = "calc_date"
        case calcType = "calc_type"
    }

}
