//
//  IndexValueViewModel.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 12.04.2023.
//

import UIKit

class IndexValueViewModel {
    
    var indexInfo: IndexInfo
    
    init(index: IndexInfo) {
        self.indexInfo = index
    }
    
    var indexDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: indexInfo.indexDate) ?? Date()
    }
    
    var indexValue: Double {
        return indexInfo.indexValue ?? 0
    }
}

