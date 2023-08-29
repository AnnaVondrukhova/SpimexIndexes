//
//  AddIndexInteractor.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import Foundation

class AddIndexInteractor {
    var presenter: AddIndexPresenter?
    
    var allIndexes = IndexesStorageManager.shared.allIndexes
    var user = UserSettingsStorage.shared.user

}

extension AddIndexInteractor {
    
    func getIndexesList(in section: SectionName) {
        //сразу фильтр по секциии и (только для тестовой выдачи !!!) по коду типа ETIP
        let filteredIndexes = allIndexes.filter({$0.section == section && $0.typeCode == "ETIP"})
        presenter?.setData(indexes: filteredIndexes)
    }
    
    func saveIndexes(in group: Group, indexCodes: [String]) {
        guard var user = user,
              let sheetIndex = user.sheets.firstIndex(where: {$0.sheetId == user.selectedSheetId}),
              let groupIndex = user.sheets[sheetIndex].groups.firstIndex(where: {$0.groupId == group.groupId}) else { return }
        
        user.sheets[sheetIndex].groups[groupIndex].products = indexCodes
        UserSettingsStorage.shared.saveUser(user: user) { success in
            if success {
                self.presenter?.didUpdateIndexCodes()
            }
        }
    }
}

