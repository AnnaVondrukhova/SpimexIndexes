//
//  TabBarViewController.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    var presenter: TabBarPresenter?
    
    override func loadView() {
        super.loadView()
        
        self.presenter = TabBarPresenter(view: self, router: TabBarRouter())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hide tab bar if there's only one tab
        self.tabBar.isHidden = true
        
        let controllers = presenter?.getTabs()
        self.viewControllers = controllers
    }
    


}

