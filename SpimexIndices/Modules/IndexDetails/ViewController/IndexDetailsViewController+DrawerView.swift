//
//  IndexDetailsViewController+DrawerView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 30.03.2023.
//

import Foundation
import DrawerView

extension IndexDetailsViewController {
    
    func setupDrawerView() {
        let drawerView = DrawerView(withView: contentView)
        drawerView.backgroundEffect = .none
        drawerView.backgroundColor = Styles.Colors.white0
        drawerView.attachTo(view: self.view)
        drawerView.delegate = self
        
        drawerView.snapPositions = [.partiallyOpen, .closed]
        drawerView.partiallyOpenHeight = UIScreen.main.bounds.height / 2
        drawerView.setPosition(.partiallyOpen, animated: true, completion: nil)
    }
}

extension IndexDetailsViewController: DrawerViewDelegate {
    
    func drawer(_ drawerView: DrawerView, didTransitionTo position: DrawerPosition) {
        
        if position == .closed {
            presenter?.close()
        }
    }
}
