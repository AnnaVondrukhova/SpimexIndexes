//
//  MenuButton.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 31.03.2023.
//

import UIKit

class MenuButton: UIView {
    
    var onSelectMenuItem: ((MenuItemProtocol) -> Void)?
    var onAddAction: (() -> Void)?
    var onEditAction: (() -> Void)?
    var enabled: Bool = true {
        didSet {
            updateButtonWidth()
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = Styles.Fonts.header
        button.setTitleColor(Styles.Colors.grey0, for: .normal)
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    let icon: UIImageView = {
        let view = UIImageView()
        view.image = Styles.Images.menu.withRenderingMode(.alwaysTemplate)
        view.tintColor = Styles.Colors.grey0
        view.height(Styles.Sizes.iconMedium)
        view.width(Styles.Sizes.iconMedium)
        return view
    }()
    
    var widthConstraint: NSLayoutConstraint!
    var font = Styles.Fonts.header
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(icon)
        addSubview(button)
        
        icon.rightToSuperview()
        icon.centerY(to: button)
        
        button.edgesToSuperview()
        widthConstraint.isActive = true
    }
    
    func setButtonTitle(text: String, enabled: Bool) {
        button.setTitle(text, for: .normal)
        
        self.enabled = enabled
//        updateButtonWidth()
    }
    
    private func updateButtonWidth() {
        var width: CGFloat = 0
        
        if enabled {
            width = (button.currentTitle?.size(withAttributes: [.font: font]).width ?? 0) + 2 * Styles.Sizes.paddingBase + 8
            button.titleEdgeInsets.left = -8
            button.alpha = 1.0
            button.isEnabled = true
            
            icon.isHidden = false
        } else {
            width = (button.currentTitle?.size(withAttributes: [.font: font]).width ?? 0) + 2 * Styles.Sizes.paddingMedium
            button.titleEdgeInsets.left = 8
            button.alpha = 0.5
            button.isEnabled = false
            
            icon.isHidden = true
        }
        
        widthConstraint.constant = width
        
        setNeedsLayout()
    }
    
    func setMenu(menu: UIMenu) {
        button.menu = menu
    }
    
    func setMenuItems(items: [MenuItemProtocol], selectedItem: MenuItemProtocol, needsAdd: Bool = false) {
        var menuItems: [UIAction] = items.map { item in
            let actionState: UIMenuElement.State = (item.menuOptionTitle == selectedItem.menuOptionTitle) ? .on : .off
            let action = UIAction(title: item.menuOptionTitle, state: actionState, handler: { (_) in
                
                self.setButtonTitle(text: item.menuOptionTitle, enabled: self.enabled)
                self.onSelectMenuItem?(item)
            })
            return action
        }
        
        if needsAdd {
            let editAction = UIAction(title: "Управление подборками", image: Styles.Images.edit.withTintColor(Styles.Colors.black0), state: .off) { (_) in
                self.onEditAction?()
            }
            
            let addAction = UIAction(title: "Добавить подборку", image: Styles.Images.plusMenu.withTintColor(Styles.Colors.black0), state: .off) { (_) in
                self.onAddAction?()
            }
            
            menuItems.append(editAction)
            menuItems.append(addAction)
        }
        
        let menu = UIMenu(options: [], children: menuItems)
        button.menu = menu
    }
}

extension MenuButton {
    
    @discardableResult
    func setButtonFont(font: UIFont) -> Self {
        self.font = font
        button.titleLabel?.font = font
        updateButtonWidth()
        
        return self
    }
    
    @discardableResult
    func setButtonTextColor(color: UIColor) -> Self {
        button.setTitleColor(color, for: .normal)
        icon.tintColor = color
        
        return self
    }
}
