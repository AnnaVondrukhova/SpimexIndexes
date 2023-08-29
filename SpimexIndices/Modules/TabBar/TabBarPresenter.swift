//
//  TabBarPresenter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation
import UIKit

class TabBarPresenter {
    var view: TabBarViewController
    var router: TabBarRouter
    
    init(view: TabBarViewController, router: TabBarRouter) {
        self.view = view
        self.router = router
    }
    
    func getTabs() -> [UIViewController] {
        let controllers = router.buildTabs()
        return controllers
    }
}

