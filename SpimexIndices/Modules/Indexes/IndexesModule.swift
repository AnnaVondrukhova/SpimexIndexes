//
//  IndexesModule.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

class IndexesModule {
    var view: IndexesViewController
    var presenter: IndexesPresenter
    var interactor: IndexesInteractor
    var router: IndexesRouter
    
    init() {
        self.view = IndexesViewController()
        self.presenter = IndexesPresenter()
        self.interactor = IndexesInteractor()
        self.router = IndexesRouter()
        
        self.view.presenter = self.presenter
        self.presenter.view = self.view
        self.presenter.interactor = self.interactor
        self.presenter.router = self.router
        
        self.interactor.presenter = self.presenter
    }
}
