//
//  IndexDetailsModule.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 23.03.2023.
//

import Foundation

class IndexDetailsModule {
    var view: IndexDetailsViewController
    var presenter: IndexDetailsPresenter
    var interactor: IndexDetailsInteractor
    var router: IndexDetailsRouter
    
    init() {
        self.view = IndexDetailsViewController()
        self.presenter = IndexDetailsPresenter()
        self.interactor = IndexDetailsInteractor()
        self.router = IndexDetailsRouter()
        
        self.view.presenter = self.presenter
        self.presenter.view = self.view
        self.presenter.interactor = self.interactor
        self.presenter.router = self.router
        
        self.interactor.presenter = self.presenter
    }
}
