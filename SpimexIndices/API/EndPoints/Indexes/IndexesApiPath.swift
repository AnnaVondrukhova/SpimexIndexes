//
//  IndexesApiPath.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

enum IndexesAPIPath: String {
    
    var basePath: String { return ""}
    
    //cases
    case indexes
    case indexCurrent
    case indexHistory
    case indexSections
    case sectionIndexesCurrent
    
    var path: String {
        switch self {
        case .indexes: return "/indexes"
        case .indexCurrent: return "/indexes/{section}-{index}/current"
        case .indexHistory: return "/indexes/{section}-{index}/history"
        case .indexSections: return "/index-sections"
        case .sectionIndexesCurrent: return "/index-sections/{section}/current"
        }
    }
}
