//
//  GroupSettingViewModel.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 31.03.2023.
//

import UIKit

protocol GroupSettingViewModelDelegate {
    func didPickMenuItem(setting: GroupSettings, item: MenuItemProtocol)
}

class GroupSettingViewModel {
    var delegate: GroupSettingViewModelDelegate?
    
    var setting: GroupSettings
    var selectedMenuItem: MenuItemProtocol
    
    init(setting: GroupSettings, selectedItem: MenuItemProtocol) {
        self.setting = setting
        self.selectedMenuItem = selectedItem
    }
    
    var settingName: String {
        return setting.settingName
    }
    
    lazy var menuItems: [UIAction] = {
        return setting.menuItems.map { item in
            let actionState: UIMenuElement.State = (item.menuOptionTitle == selectedMenuItem.menuOptionTitle) ? .on : .off
            let action = UIAction(title: item.menuOptionTitle, state: actionState, handler: { (_) in
                self.pickMenuItem(item: item)
            })
            return action
        }
    }()
    
    var canChangeSetting: Bool = true

    func pickMenuItem(item: MenuItemProtocol) {
        delegate?.didPickMenuItem(setting: setting, item: item)
    }
}
