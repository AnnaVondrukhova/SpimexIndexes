//
//  EditSheetCell.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 26.04.2023.
//

import UIKit

class EditSheetCell: UITableViewCell {

    static let cellReuseId = String(describing: EditSheetCell.self)
    var viewModel: SheetViewModel?
    
    var onTapEdit: ((Sheet) -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.titleRegular
        label.textAlignment = .left
        label.textColor = Styles.Colors.black0
        return label
    }()
    
    private lazy var editButton: IconButton = {
        let button = IconButton()
        button.setIcon(icon: Styles.Images.edit)
            .setIconColor(color: Styles.Colors.blue0)
            .setIconSize(size: Styles.Sizes.iconBig)
            .setButtonColor(color: .clear)
        
        button.action = { [weak self] in
            guard let sheet = self?.viewModel?.sheet else { return }
            self?.onTapEdit?(sheet)
        }
        button.height(Styles.Sizes.buttonMedium)
        button.widthToHeight(of: button)
        
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.grey1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(separatorView)
        
        titleLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        titleLabel.centerYToSuperview()
        
        editButton.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        editButton.centerYToSuperview()
        editButton.leftToRight(of: titleLabel, offset: Styles.Sizes.paddingBase)
        
        separatorView.edgesToSuperview(excluding: .top)
        separatorView.height(Styles.Sizes.separatorHeight)
    }
    
    func configure(_ viewModel: SheetViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.menuOptionTitle
    }
}

