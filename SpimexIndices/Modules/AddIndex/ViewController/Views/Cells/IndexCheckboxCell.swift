//
//  IndexCheckboxCell.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 28.03.2023.
//

import UIKit

class IndexCheckboxCell: UITableViewCell {

    var onTap: ((String) -> Void)?
    var viewModel: AddIndexViewModel?
    
    var isOn: Bool = false {
        didSet {
            checkbox.image = isOn ? Styles.Images.checkboxOn : Styles.Images.checkboxOff
        }
    }
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.titleRegular
        label.textAlignment = .left
        label.textColor = Styles.Colors.black0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.subtitle
        label.textAlignment = .left
        label.textColor = Styles.Colors.grey0
        label.numberOfLines = 2
        return label
    }()
    
    private let checkbox: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.height(Styles.Sizes.iconMedium)
        view.width(Styles.Sizes.iconMedium)
        return view
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
        contentView.backgroundColor = Styles.Colors.white0
        self.accessoryView?.backgroundColor = Styles.Colors.white0
        
        contentView.addSubview(codeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(checkbox)
        contentView.addSubview(separatorView)
        
        codeLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        codeLabel.topToSuperview(offset: Styles.Sizes.paddingMedium)
        
        descriptionLabel.leftToSuperview(offset: Styles.Sizes.paddingBase)
        descriptionLabel.bottomToSuperview(offset: -Styles.Sizes.paddingMedium)
        descriptionLabel.topToBottom(of: codeLabel, offset: -Styles.Sizes.paddingSmall)
        
        checkbox.rightToSuperview(offset: -Styles.Sizes.paddingBase)
        checkbox.centerYToSuperview()
        codeLabel.rightToLeft(of: checkbox, offset: -Styles.Sizes.paddingBase)
        descriptionLabel.rightToLeft(of: checkbox, offset: -Styles.Sizes.paddingBase)

        separatorView.edgesToSuperview(excluding: .top)
        separatorView.height(Styles.Sizes.separatorHeight)
    }
    
    func configure(_ viewModel: AddIndexViewModel) {
        self.viewModel = viewModel
        
        codeLabel.text = viewModel.indexCode
        descriptionLabel.text = viewModel.indexDescription
        isOn = viewModel.isSelected
    }
}

extension IndexCheckboxCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchToContent(touches) {
            scaleDown()
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        scaleDown(false)
        
        super.touchesCancelled(touches!, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchToContent(touches) {
            scaleDown(true)
        } else {
            scaleDown(false)
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        func action() {
            guard let vm = viewModel else { return }
            
            isOn.toggle()
            onTap?(vm.indexCode)
        }
        
        if touchToContent(touches) {
            scaleDown()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
                action()
                self?.scaleDown(false)
            }
        } else {
            scaleDown(false)
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    private func touchToContent(_ touches: Set<UITouch>) -> Bool {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            
            return true
        }
        
        return false
    }
}
