//
//  IndexInfoHeaderView.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 21.03.2023.
//

import Foundation
import UIKit

class IndexInfoHeaderView: UIView {
    
    var onTapEdit: ((Group) -> Void)?
    var onTapDelete: ((Group) -> Void)?
    var group: Group?
    
    var contentView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.title
        label.textAlignment = .left
        label.textColor = Styles.Colors.blue0
        return label
    }()
    
    private lazy var editButton: IconButton = {
        let button = IconButton()
        button.setIcon(icon: Styles.Images.edit)
            .setIconColor(color: Styles.Colors.blue0)
            .setIconSize(size: Styles.Sizes.iconBig)
            .setButtonColor(color: .clear)
        
        button.action = { [weak self] in
            guard let group = self?.group else { return }
            self?.onTapEdit?(group)
        }
        button.height(Styles.Sizes.buttonMedium)
        button.widthToHeight(of: button)
        
        return button
    }()
    
    private lazy var deleteButton: IconButton = {
        let button = IconButton()
        button.setIcon(icon: Styles.Images.delete)
            .setIconColor(color: Styles.Colors.blue0)
            .setIconSize(size: Styles.Sizes.iconBase)
            .setButtonColor(color: .clear)
        
        button.action = { [weak self] in
            guard let group = self?.group else { return }
            self?.onTapDelete?(group)
        }
        button.height(Styles.Sizes.buttonMedium)
        button.widthToHeight(of: button)
        
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.blue1
        return view
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
        let stack = UIStackView(arrangedSubviews: [titleLabel, editButton, deleteButton])
        stack.axis = .horizontal
        stack.spacing = .zero
        stack.alignment = .center
        
        addSubview(contentView)
        contentView.addSubview(stack)
        contentView.addSubview(separatorView)
        
        contentView.edgesToSuperview()
        contentView.height(Styles.Sizes.buttonBase)
        
        stack.leftToSuperview(offset: Styles.Sizes.paddingBase)
        stack.rightToSuperview(offset: -Styles.Sizes.paddingBase / 2)
        stack.centerYToSuperview()
        
        separatorView.edgesToSuperview(excluding: .top)
        separatorView.height(Styles.Sizes.separatorHeight)
    }
    
    func configure(group: Group?) {
        self.group = group
        titleLabel.text = group?.groupName
    }
    
    func setEditing(_ editing: Bool) {
        editButton.isHidden = editing
        deleteButton.isHidden = editing
    }

}


