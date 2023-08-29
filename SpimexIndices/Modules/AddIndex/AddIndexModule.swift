//
//  AddIndexModule.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import Foundation

class AddIndexModule {
    var view: AddIndexViewController
    var presenter: AddIndexPresenter
    var interactor: AddIndexInteractor
    var router: AddIndexRouter
    
    init() {
        self.view = AddIndexViewController()
        self.presenter = AddIndexPresenter()
        self.interactor = AddIndexInteractor()
        self.router = AddIndexRouter()
        
        self.view.presenter = self.presenter
        self.presenter.view = self.view
        self.presenter.interactor = self.interactor
        self.presenter.router = self.router
        
        self.interactor.presenter = self.presenter
    }
}
