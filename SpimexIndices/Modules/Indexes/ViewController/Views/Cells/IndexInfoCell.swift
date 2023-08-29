//
//  IndexInfoCell.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 14.03.2023.
//

import UIKit

class IndexInfoCell: UITableViewCell {

    static let cellReuseId = String(describing: IndexInfoCell.self)
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.title
        label.textAlignment = .left
        label.textColor = Styles.Colors.black0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.subtitle
        label.textAlignment = .left
        label.textColor = Styles.Colors.grey0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.title
        label.textAlignment = .right
        label.textColor = Styles.Colors.black0
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.caption
        label.textAlignment = .right
        return label
    }()
    
    private let priceChangeImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.grey1
        return view
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [codeLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = Styles.Sizes.paddingSmall
        stack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return stack
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, priceChangeLabel])
        stack.axis = .vertical
        stack.spacing = Styles.Sizes.paddingSmall
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stack
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
        contentView.backgroundColor = Styles.Colors.white0
        
        let stack = UIStackView(arrangedSubviews: [nameStack, priceStack, priceChangeImage])
        stack.spacing = Styles.Sizes.paddingMedium
        stack.alignment = .center
        
        contentView.addSubview(stack)
        contentView.addSubview(separatorView)
        
        stack.edgesToSuperview(insets: UIEdgeInsets(top: Styles.Sizes.paddingMedium,
                                                    left: Styles.Sizes.paddingBase,
                                                    bottom: Styles.Sizes.paddingMedium,
                                                    right: Styles.Sizes.paddingBase))

        priceChangeImage.height(Styles.Sizes.iconBase)
        priceChangeImage.widthToHeight(of: priceChangeImage)

        separatorView.edgesToSuperview(excluding: .top)
        separatorView.height(Styles.Sizes.separatorHeight)
    }
    
    func configure(_ viewModel: IndexViewModel, isEditing: Bool) {
        codeLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        priceLabel.text = viewModel.price.formattedWithSeparator
        priceChangeLabel.text = String(format: "%.2f", viewModel.priceChange) + "%"
        priceChangeLabel.textColor = viewModel.tintColor
        
        priceChangeImage.image = viewModel.icon.withRenderingMode(.alwaysTemplate)
        priceChangeImage.tintColor = viewModel.tintColor
        
        priceStack.isHidden = isEditing
        priceChangeImage.isHidden = isEditing
    }
}
