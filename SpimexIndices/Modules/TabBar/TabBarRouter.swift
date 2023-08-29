//
//  TabBarRouter.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation
import UIKit

class TabBarRouter {
    
    func buildTabs() -> [UIViewController] {
        let indexesModule = IndexesModule()
        let indexesNavigationController = UINavigationController(rootViewController: indexesModule.view)
        
        indexesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return [indexesNavigationController]
    }
}
