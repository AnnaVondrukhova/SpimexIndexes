//
//  AddIndexContentView+Search.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import UIKit

extension AddIndexContentView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(self.searchIndex),
                                               object: nil)
        
        self.perform(#selector(self.searchIndex),
                     with: nil,
                     afterDelay: 0.3)
        
    }
    
    @objc func searchIndex() {
        let keyWords: [Substring] = searchText.lowercased().split(separator: " ")
        
        var filteredVMs: [AddIndexViewModel] = []
        
        if !keyWords.isEmpty {
            filteredVMs = indexVMs.filter { vm in
                var contains = true
                for word in keyWords {
                    if !vm.indexCode.lowercased().contains(word) &&
                        !vm.indexDescription.lowercased().contains(word) {
                        contains = false
                    }
                }
                
                return contains
            }
        } else {
            filteredVMs = indexVMs
        }
        
        updateData(viewModels: filteredVMs)
    }
}
