//
//  IndexDetailsInteractor.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 23.03.2023.
//

import Foundation

class IndexDetailsInteractor {
    var presenter: IndexDetailsPresenter?
    
    private lazy var indexRequestManager = IndexRequestManager()
}

extension IndexDetailsInteractor {
    
    func getIndexHistory(section: SectionName, indexCode: String, dateFrom: Date?, dateTo: Date?, period: IndexPeriod) {
        var request = IndexRequest(section: section, indexCode: indexCode)
        
        if let dateFrom = dateFrom,
           let dateTo = dateTo {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            let dateFromString = formatter.string(from: dateFrom)
            let dateToString = formatter.string(from: dateTo)
            
            request.dateFrom = dateFromString
            request.dateTo = dateToString
        }
        
        var items: [IndexInfo] = []
        
        indexRequestManager.getIndexHistory(request: request, period: period) {[weak self] result in
            switch result {
            case .success(let data):
                guard let values = data.body?.data else { return }
                
                items.append(contentsOf: values)
                self?.presenter?.setData(items)
            case .failure(let error):
                break
            }
        }
    }
}
