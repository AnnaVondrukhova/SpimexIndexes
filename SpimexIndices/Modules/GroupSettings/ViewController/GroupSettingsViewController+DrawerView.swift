//
//  GroupSettingsViewController+DrawerView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 30.03.2023.
//

import Foundation
import DrawerView

extension GroupSettingsViewController {
    
    func setupDrawerView() {
        let drawerView = DrawerView(withView: contentView)
        drawerView.backgroundEffect = .none
        drawerView.backgroundColor = Styles.Colors.white0
        drawerView.attachTo(view: self.view)
        drawerView.delegate = self
        
        drawerView.snapPositions = [.partiallyOpen, .closed]
        drawerView.setPosition(.partiallyOpen, animated: true, completion: nil)
    }
}

extension GroupSettingsViewController: DrawerViewDelegate {
    
    func drawer(_ drawerView: DrawerView, willTransitionFrom startPosition: DrawerPosition, to targetPosition: DrawerPosition) {
        if targetPosition == .closed {
            contentView.endEditing(true)
        }
    }
    func drawer(_ drawerView: DrawerView, didTransitionTo position: DrawerPosition) {
        
        if position == .closed {
            presenter?.close()
        }
    }
}
