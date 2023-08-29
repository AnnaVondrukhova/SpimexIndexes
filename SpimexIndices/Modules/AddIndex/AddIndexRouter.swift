//
//  AddIndexRouter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import Foundation

class AddIndexRouter {
    
    func close(presenter: AddIndexPresenter) {
        presenter.view?.dismiss(animated: true, completion: nil)
    }
}
