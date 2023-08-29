//
//  IndexInfoFooterView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 23.03.2023.
//

import UIKit

class IndexInfoFooterView: UIView {
    
    var group: Group?
    var onTap: ((Group) -> Void)?
    
    private lazy var addButton: IconTextButton = {
        let button = IconTextButton()
        button.setTitle(title: "Добавить индекс")
            .setTitleColor(color: Styles.Colors.blue1)
            .setTitleFont(font: Styles.Fonts.buttonThin)
            .setIcon(icon: Styles.Images.plusThin)
            .setIconSize(size: Styles.Sizes.iconMedium)
            .setIconColor(color: Styles.Colors.blue1)
            .setButtonColor(color: Styles.Colors.white0)
        
        button.action = { [weak self] in
            guard let group = self?.group else { return }
            self?.onTap?(group)
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
    
    func configure(group: Group?) {
        self.group = group
    }

    @objc func didTapButton() {
        guard let group = group else { return }
        
        onTap?(group)
    }
}


