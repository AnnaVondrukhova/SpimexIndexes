//
//  IconTextButton.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 29.03.2023.
//

import UIKit

class IconTextButton: TextButton {
    
    enum IconPosition: Int {
        case left
        case right
    }
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private let iconPosition: IconPosition
    
    init(frame: CGRect = .zero, iconPosition: IconPosition = .left) {
        self.iconPosition = iconPosition
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
//        setIconSize(size: Styles.Sizes.iconBase)
        stackView.insertArrangedSubview(icon, at: iconPosition.rawValue)
    }
}

extension IconTextButton {
    
    @discardableResult
    func setIcon(icon: UIImage) -> Self {
        self.icon.image = icon.withRenderingMode(.alwaysTemplate)
        self.icon.isHidden = false
        
        return self
    }
    
    @discardableResult
    func setIconColor(color: UIColor) -> Self {
        self.icon.tintColor = color
        
        return self
    }
    
    @discardableResult
    func setIconSize(size: CGFloat) -> Self {
        self.icon.size(CGSize(width: size, height: size))
        
        return self
    }
}
