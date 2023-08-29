//
//  GroupSettingCell.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 31.03.2023.
//

import UIKit

class GroupSettingCell: UITableViewCell {
    
    static let cellReuseId = String(describing: GroupSettingCell.self)

    var viewModel: GroupSettingViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.title
        label.textAlignment = .left
        label.textColor = Styles.Colors.black0
        return label
    }()
    
    private var menuButton: MenuButton = {
        let button = MenuButton()
        button.setButtonFont(font: Styles.Fonts.title)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.selectionStyle = .none
        contentView.backgroundColor = Styles.Colors.white0
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(menuButton)
        
        menuButton.edgesToSuperview(excluding: .left, insets: UIEdgeInsets(top: Styles.Sizes.paddingSmall,
                                                                           left: .zero,
                                                                           bottom: Styles.Sizes.paddingSmall,
                                                                           right: Styles.Sizes.paddingBase))
        menuButton.height(Styles.Sizes.buttonBase)
        
        titleLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        titleLabel.centerY(to: menuButton)
    }
    
    func configure(_ viewModel: GroupSettingViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.settingName
        
        menuButton.setButtonTitle(text: viewModel.selectedMenuItem.menuOptionTitle, enabled: viewModel.canChangeSetting)
        menuButton.setMenuItems(items: viewModel.setting.menuItems, selectedItem: viewModel.selectedMenuItem)
        menuButton.onSelectMenuItem = { [weak self] (item) in
            guard let viewModel = self?.viewModel else { return }
            viewModel.delegate?.didPickMenuItem(setting: viewModel.setting, item: item)
        }
        
        setupViews()
    }
}
