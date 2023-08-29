//
//  AddGroupFooterView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 29.03.2023.
//

import UIKit

class AddGroupFooterView: UIView {
    
    var onTap: (() -> Void)?
    
    private lazy var addButton: IconTextButton = {
        let button = IconTextButton()
        button.setTitle(title: "Добавить группу")
            .setTitleColor(color: Styles.Colors.white0)
            .setTitleFont(font: Styles.Fonts.buttonBase)
            .setIcon(icon: Styles.Images.plusThin)
            .setIconColor(color: Styles.Colors.white0)
            .setIconSize(size: Styles.Sizes.iconMedium)
            .setButtonColor(color: Styles.Colors.blue1)
            .setCornerRadius(radius: Styles.Sizes.cornerRadiusMedium)
        
        button.action = { [weak self] in
            self?.onTap?()
        }
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(addButton)
        
        addButton.height(Styles.Sizes.buttonBase)
        addButton.edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40))
    }

}



