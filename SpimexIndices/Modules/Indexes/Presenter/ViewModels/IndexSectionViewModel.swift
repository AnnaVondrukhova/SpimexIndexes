//
//  IndexSectionViewModel.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 21.03.2023.
//

import Foundation

class IndexSectionViewModel {
    
    var indexVMs: [IndexViewModel]
    var group: Group
    
    init(group: Group, indexVMs: [IndexViewModel]) {
        self.indexVMs = indexVMs
        self.group = group
    }
    
    var groupTitle: String {
        return group.groupName
    }
}
