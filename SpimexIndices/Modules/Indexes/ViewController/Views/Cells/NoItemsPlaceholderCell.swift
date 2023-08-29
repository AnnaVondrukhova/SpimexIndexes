//
//  NoItemsPlaceholderCell.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 26.04.2023.
//

import UIKit

class NoItemsPlaceholderCell: UITableViewCell {

    static let cellReuseId = String(describing: NoItemsPlaceholderCell.self)
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.grey2
        view.layer.cornerRadius = Styles.Sizes.cornerRadiusMedium
        view.layer.masksToBounds = true
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.subtitle
        label.text = "В подборке нет добавленных групп"
        label.textAlignment = .center
        label.textColor = Styles.Colors.grey0
        label.numberOfLines = 0
        return label
    }()
    
    var topConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        topConstraint = NSLayoutConstraint(item: bgView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(descriptionLabel)
        
        bgView.edgesToSuperview(excluding: .top, insets: UIEdgeInsets(top: 0,
                                                     left: Styles.Sizes.paddingBase,
                                                     bottom: 0,
                                                     right: Styles.Sizes.paddingBase))
        
        topConstraint?.isActive = true
        bgView.height(60)
        
        descriptionLabel.rightToSuperview(offset: -2 * Styles.Sizes.paddingBase)
        descriptionLabel.leftToSuperview(offset: 2 * Styles.Sizes.paddingBase)
        descriptionLabel.centerYToSuperview()
        
    }
    
    func configure(text: String, topInset: CGFloat = 0) {
        descriptionLabel.text = text
        
        topConstraint?.constant = topInset
        setNeedsLayout()
    }
}
