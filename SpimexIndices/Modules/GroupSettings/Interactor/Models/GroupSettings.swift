//
//  GroupSettings.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 31.03.2023.
//

import Foundation

protocol MenuItemProtocol {
    var menuOptionTitle: String { get }
}

enum GroupSettings: CaseIterable {
    case section
    case title
    case subtitle
    
    var settingName: String {
        switch self {
        case .section:
            return "Секция"
        case .title:
            return "Заголовок"
        case .subtitle:
            return "Подзаголовок"
        }
    }
    
    var menuItems: [MenuItemProtocol] {
        switch self {
        case .section:
            return SectionName.allCases.reversed()
        case .title:
            return TitleSettings.allCases.reversed()
        case .subtitle:
            return SubtitleSettings.allCases.reversed()
        }
    }
}

enum TitleSettings: MenuItemProtocol, CaseIterable, Codable {
    case indexCode
    case productCode
    case productName
    case placeCode
    case placeName
    
    var menuOptionTitle: String {
        switch self {
        case .indexCode:
            return "Код индекса"
        case .productCode:
            return "Код продукта"
        case .productName:
            return "Название продукта"
        case .placeCode:
            return "Код места"
        case .placeName:
            return "Название места"
        }
    }
}

enum SubtitleSettings: MenuItemProtocol, CaseIterable, Codable {
    case indexCode
    case productCode
    case productName
    case placeCode
    case placeName
    
    var menuOptionTitle: String {
        switch self {
        case .indexCode:
            return "Код индекса"
        case .productCode:
            return "Код продукта"
        case .productName:
            return "Название продукта"
        case .placeCode:
            return "Код места"
        case .placeName:
            return "Название места"
        }
    }
}
