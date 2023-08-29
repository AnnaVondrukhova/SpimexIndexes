//
//  SectionName.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 16.03.2023.
//

import Foundation

enum SectionName: String, Codable, MenuItemProtocol, CaseIterable {
    case petroleum = "petroleum"
    case gas = "gas"
    case oil = "oil"
    case coal = "coal"
    case bitumen = "bitumen"
    
    var menuOptionTitle: String {
        switch self {
        case .petroleum:
            return "Нефтепродукты"
        case .gas:
            return "Газ"
        case .oil:
            return "Нефть"
        case .coal:
            return "Уголь"
        case .bitumen:
            return "Битум"
        }
    }
}
