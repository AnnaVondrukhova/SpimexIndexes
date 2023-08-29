//
//  AddIndexPresenter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import Foundation

protocol AddIndexModuleDelegate {
    func didUpdateIndexCodes()
}

class AddIndexPresenter {
    var view: AddIndexViewController?
    var interactor: AddIndexInteractor?
    var router: AddIndexRouter?
    
    var delegate: AddIndexModuleDelegate?
    var group: Group?
}

extension AddIndexPresenter {
    func didLoadView() {
        guard let group = group else { return }
        
        interactor?.getIndexesList(in: group.section)
    }
    
    func saveIndexes(indexCodes: [String]) {
        guard let group = group else { return }
        
        interactor?.saveIndexes(in: group, indexCodes: indexCodes)
    }
    
    func close() {
        router?.close(presenter: self)
    }
}

extension AddIndexPresenter {
    
    func setData(indexes: [Index]) {
        guard let group = self.group else { return }
        
        let vms: [AddIndexViewModel] = indexes.map { index in
            let vm = AddIndexViewModel(index: index, selected: group.products.contains(index.code))
            return vm
        }
        
        view?.setData(viewModels: vms)
    }
    
    func didUpdateIndexCodes() {
        delegate?.didUpdateIndexCodes()
    }
}

extension AddIndexPresenter {
    
    func setGroup(_ group: Group) {
        self.group = group
    }
}
