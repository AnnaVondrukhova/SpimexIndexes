//
//  IndexesPresenter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation
import UIKit

class IndexesPresenter {
    var view: IndexesViewController?
    var interactor: IndexesInteractor?
    var router: IndexesRouter?
    
    
}


extension IndexesPresenter {
    
    func didLoadView() {
        interactor?.getUserSheets()
        interactor?.getUserIndexes()
    }
    
    func editGroup(group: Group) {
        router?.openGroupSettings(group: group, presenter: self)
    }
    
    func deleteGroup(group: Group) {
        interactor?.deleteGroup(group: group)
    }
    
    func addGroup() {
        router?.openGroupSettings(group: nil, presenter: self)
    }
    
    func deleteProduct(in group: Group, at index: Int) {
        interactor?.deleteProduct(in: group, at: index)
    }
    
    func moveProduct(in group: Group, from indexFrom: Int, to indexTo: Int) {
        interactor?.moveProduct(in: group, from: indexFrom, to: indexTo)
    }
    
    func didTapIndexDetails(indexVM: IndexViewModel) {
        router?.openIndexDetailsModule(vm: indexVM, presenter: self)
    }
    
    func didTapAddProduct(in group: Group) {
        router?.openAddIndexModule(group: group, presenter: self)
    }
    
    func editSheets() {
        router?.openEditSheets(presenter: self)
    }
    
    func saveSheet(title: String) {
        interactor?.saveSheet(title: title)
    }
    
    func didSelectSheet(sheet: Sheet) {
        interactor?.switchSheet(sheet: sheet)
    }
}

extension IndexesPresenter {
    
    func setSheets(_ sheets: [Sheet], selectedSheet: Sheet) {
        let sheetVMs: [SheetViewModel] = sheets.map({SheetViewModel(sheet: $0)})
        let selectedSheetVM = SheetViewModel(sheet: selectedSheet)
        
        view?.setSheets(sheetVMs, selectedSheet: selectedSheetVM)
    }
    
    func setData(items: [Group : [IndexInfo]]) {
        var sectionVMs: [IndexSectionViewModel] = []
        
        items.forEach { item in
            let vms: [IndexViewModel] = item.value.map { indexInfo in
                let indexNameInfo = interactor?.allIndexes.first(where: {$0.code == indexInfo.indexCode})
                let vm = IndexViewModel(index: indexNameInfo, indexInfo: indexInfo, group: item.key)
                return vm
            }
            
            sectionVMs.append(IndexSectionViewModel(group: item.key, indexVMs: vms))
        }
        
        let sortedVMs = sectionVMs.sorted(by: {$0.group.sortIndex < $1.group.sortIndex})
        
        
        view?.setData(viewModels: sortedVMs)
    }
}

extension IndexesPresenter: AddIndexModuleDelegate {
    
    func didUpdateIndexCodes() {
        interactor?.getUserIndexes()
    }
}

extension IndexesPresenter: GroupSettingsModuleDelegate {
    
    func didUpdateGroup() {
        interactor?.getUserIndexes()
    }
}

extension IndexesPresenter: EditSheetsModuleDelegate {
    
    func didUpdateSheets() {
        interactor?.getUserSheets()
        interactor?.getUserIndexes()
    }
    
    func didUpdateSheetName() {
        interactor?.getUserSheets()
    }
}
