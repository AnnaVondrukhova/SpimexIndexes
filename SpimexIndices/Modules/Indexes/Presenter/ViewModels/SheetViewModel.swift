//
//  SheetViewModel.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 19.04.2023.
//

import Foundation

class SheetViewModel: MenuItemProtocol {
    
    var sheet: Sheet
    
    init(sheet: Sheet) {
        self.sheet = sheet
    }
    
    var menuOptionTitle: String {
        return sheet.sheetName
    }
}
