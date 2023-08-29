//
//  IndexDetailsPresenter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 23.03.2023.
//

import Foundation

class IndexDetailsPresenter {
    var view: IndexDetailsViewController?
    var interactor: IndexDetailsInteractor?
    var router: IndexDetailsRouter?
    
    var _viewModel: IndexViewModel?
}

extension IndexDetailsPresenter {
    
    func didLoadView() {
        guard let viewModel = _viewModel else { return }
        
        view?.setIndex(viewModel: viewModel)
        view?.setupViews()
    }
    
    func didSelectPeriod(_ period: IndexPeriod) {
        let calendar = Calendar.current
        let today = Date()
        var startDate: Date?
        
        switch period {
        case .week:
            startDate = calendar.date(byAdding: .day, value: -7, to: today)
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: today)
        case .quarter:
            startDate = calendar.date(byAdding: .month, value: -3, to: today)
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: today)
        case .all:
            startDate = nil
        }
        
        guard let section = _viewModel?.index?.section,
              let indexCode = _viewModel?.index?.code else { return }
        
        interactor?.getIndexHistory(section: section, indexCode: indexCode, dateFrom: startDate, dateTo: today, period: period)
    }
    
    func close() {
        router?.close(presenter: self)
    }
}

//interactor output
extension IndexDetailsPresenter {
    
    func setData(_ indexes: [IndexInfo]) {
        let vms: [IndexValueViewModel] = indexes.map {IndexValueViewModel(index: $0)}
        
        view?.setData(viewModels: vms)
    }
}

//module input
extension IndexDetailsPresenter {
    
    func setIndexVM(vm: IndexViewModel) {
        self._viewModel = vm
    }
}
