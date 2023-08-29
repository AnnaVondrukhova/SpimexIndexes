//
//  IndexDetailsRouter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 23.03.2023.
//

import Foundation

class IndexDetailsRouter {
    
    func close(presenter: IndexDetailsPresenter) {
        presenter.view?.dismiss(animated: false, completion: nil)
    }
}
