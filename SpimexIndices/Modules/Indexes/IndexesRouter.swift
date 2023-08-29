//
//  IndexesRouter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation
import UIKit

class IndexesRouter {
    
    func openGroupSettings(group: Group?, presenter: IndexesPresenter) {
        let groupSettingsModule = GroupSettingsModule()
        groupSettingsModule.presenter.setGroup(group)
        groupSettingsModule.presenter.delegate = presenter
        
        let groupSettingsVC = groupSettingsModule.view
        groupSettingsVC.modalPresentationStyle = .overFullScreen
        presenter.view?.present(groupSettingsVC, animated: false, completion: nil)
    }
    
    func openEditSheets(presenter: IndexesPresenter) {
        let editSheetsModule = EditSheetsModule()
        editSheetsModule.presenter.delegate = presenter
        
        let editSheetsVC = editSheetsModule.view
        editSheetsVC.modalPresentationStyle = .overFullScreen
        presenter.view?.present(editSheetsVC, animated: false, completion: nil)
    }
    
    func openIndexDetailsModule(vm: IndexViewModel, presenter: IndexesPresenter) {
        let indexDetailsModule = IndexDetailsModule()
        indexDetailsModule.presenter.setIndexVM(vm: vm)
        
        let indexDetailsVC = indexDetailsModule.view
        indexDetailsVC.modalPresentationStyle = .overFullScreen
        presenter.view?.present(indexDetailsVC, animated: false, completion: nil)
    }
    
    func openAddIndexModule(group: Group, presenter: IndexesPresenter) {
        let addIndexModule = AddIndexModule()
        addIndexModule.presenter.setGroup(group)
        addIndexModule.presenter.delegate = presenter
        
        let addIndexVC = UINavigationController(rootViewController: addIndexModule.view) 
        
        addIndexVC.modalPresentationStyle = .overFullScreen
        addIndexVC.modalTransitionStyle = .crossDissolve
        presenter.view?.present(addIndexVC, animated: true, completion: nil)
    }
}
