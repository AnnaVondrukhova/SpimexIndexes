//
//  EditSheetFooterView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 26.04.2023.
//

import UIKit

class EditSheetFooterView: UIView {
    
    var onTap: (() -> Void)?
    
    private lazy var addButton: IconTextButton = {
        let button = IconTextButton()
        button.setTitle(title: "Добавить подборку")
            .setTitleColor(color: Styles.Colors.blue1)
            .setTitleFont(font: Styles.Fonts.buttonThin)
            .setIcon(icon: Styles.Images.plusThin)
            .setIconSize(size: Styles.Sizes.iconMedium)
            .setIconColor(color: Styles.Colors.blue1)
            .setButtonColor(color: Styles.Colors.white0)
        
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
        addButton.edgesToSuperview(insets: UIEdgeInsets(top: Styles.Sizes.paddingSmall, left: 40, bottom: 0, right: 40))
    }
}


