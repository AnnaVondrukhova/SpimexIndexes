//
//  AddIndexViewModel.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import UIKit

class AddIndexViewModel {
    
    var index: Index?
    var isSelected: Bool = false
    
    init(index: Index?, selected: Bool) {
        self.index = index
        self.isSelected = selected
    }
    
    var indexCode: String {
        return index?.code ?? ""
    }
    
    var indexDescription: String {
        return index?.name ?? ""
    }
}
