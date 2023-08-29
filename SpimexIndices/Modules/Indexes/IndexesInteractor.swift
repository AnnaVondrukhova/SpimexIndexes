//
//  IndexesInteractor.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

class IndexesInteractor {
    var presenter: IndexesPresenter?
    
    private let indexesRequestManager = IndexRequestManager()
    
    var allIndexes = IndexesStorageManager.shared.allIndexes
    var indexesInfo: [Group : [IndexInfo]] = [:]
    var user = UserSettingsStorage.shared.user
    let dispatchGroup = DispatchGroup()
    
    init() {
        IndexesStorageManager.shared.addListener(self)
        UserSettingsStorage.shared.addListener(self)
    }
}

extension IndexesInteractor {
    
    func getUserSheets() {
        guard let user = user,
              let selectedSheetIndex = user.sheets.firstIndex(where: {$0.sheetId == user.selectedSheetId}) else { return }
        
        presenter?.setSheets(user.sheets, selectedSheet: user.sheets[selectedSheetIndex])
    }
    
    func getUserIndexes() {
        guard let user = user,
              let sheetIndex = user.sheets.firstIndex(where: {$0.sheetId == user.selectedSheetId}) else { return }
              
        if user.sheets[sheetIndex].groups.isEmpty {
            presenter?.setData(items: [:])
            return
        }
        
        indexesInfo = [:]
        
        for i in 0 ..< user.sheets[sheetIndex].groups.count {
            var group = user.sheets[sheetIndex].groups[i]
            group.sortIndex = i
            
            dispatchGroup.enter()
            
            indexesRequestManager.getSectionIndexes(section: group.section) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    if let items = data.body {
                        var filteredItems: [IndexInfo] = []
                        
                        for product in group.products {
                            if let item = items.first(where: {$0.indexCode == product}) {
                                filteredItems.append(item)
                            }
                        }
                        self.indexesInfo[group] = filteredItems
                        self.dispatchGroup.leave()
                    }
                    
                case .failure(let error):
                    break
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            if !self.allIndexes.isEmpty {
                self.presenter?.setData(items: self.indexesInfo)
            }
        }
        
    }
    
    func deleteProduct(in group: Group, at index: Int) {
        guard var user = user,
              let sheetIndex = user.sheets.firstIndex(where: {$0.sheetId == user.selectedSheetId}),
              let groupIndex = user.sheets[sheetIndex].groups.firstIndex(where: {$0.groupId == group.groupId}) else { return }
        
        user.sheets[sheetIndex].groups[groupIndex].products.remove(at: index)
        UserSettingsStorage.shared.saveUser(user: user)
    }
    
    func moveProduct(in group: Group, from indexFrom: Int, to indexTo: Int) {
        guard var user = user,
              let sheetIndex = user.sheets.firstIndex(where: {$0.sheetId == user.selectedSheetId}),
              let groupIndex = user.sheets[sheetIndex].groups.firstIndex(where: {$0.groupId == group.groupId}) else { return }
        
        let product = user.sheets[sheetIndex].groups[groupIndex].products[indexFrom]
        user.sheets[sheetIndex].groups[groupIndex].products.remove(at: indexFrom)
        user.sheets[sheetIndex].groups[groupIndex].products.insert(product, at: indexTo)
        
        UserSettingsStorage.shared.saveUser(user: user)
    }
    
    func deleteGroup(group: Group) {
        guard var user = user,
              let sheetIndex = user.sheets.firstIndex(where: {$0.sheetId == user.selectedSheetId}),
              let groupIndex = user.sheets[sheetIndex].groups.firstIndex(where: {$0.groupId == group.groupId}) else { return }
        
        user.sheets[sheetIndex].groups.remove(at: groupIndex)
        UserSettingsStorage.shared.saveUser(user: user)
    }
    
    func saveSheet(title: String) {
        guard var user = user else { return }
        
        let newSheet = Sheet(sheetId: UUID().uuidString, sheetName: title, groups: [])
        user.sheets.append(newSheet)
        user.selectedSheetId = newSheet.sheetId
        
        UserSettingsStorage.shared.saveUser(user: user) { _ in
            self.getUserSheets()
            self.getUserIndexes()
        }
    }
    
    func switchSheet(sheet: Sheet) {
        guard var user = user,
              user.selectedSheetId != sheet.sheetId else { return }
        
        user.selectedSheetId = sheet.sheetId
        UserSettingsStorage.shared.saveUser(user: user) { _ in
            self.getUserSheets()
            self.getUserIndexes()
        }
    }
}

extension IndexesInteractor: IndexListener {
    func didUpdateIndexes() {
        if !indexesInfo.isEmpty {
            presenter?.setData(items: indexesInfo)
        }
    }
}

extension IndexesInteractor: UserListener {
    func didUpdateUser(user: User) {
        self.user = user
    }
}
