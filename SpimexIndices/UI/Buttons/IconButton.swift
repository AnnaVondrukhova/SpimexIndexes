//
//  IconButton.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 29.03.2023.
//

import UIKit

class IconButton: UIView {
    
    var action: (() -> Void)?
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
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
        self.addSubview(icon)
        
//        setIconSize(size: Styles.Sizes.iconBase)
        icon.centerInSuperview()
    }
}

extension IconButton {
    
    @discardableResult
    func setButtonColor(color: UIColor) -> Self {
        self.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    func setIcon(icon: UIImage) -> Self {
        self.icon.image = icon.withRenderingMode(.alwaysTemplate)
        
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
    
    @discardableResult
    func setBorderColor(color: UIColor) -> Self {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2.0
        
        return self
    }
    
    @discardableResult
    func setBorderWidth(width: CGFloat) -> Self {
        self.layer.borderWidth = width
        
        return self
    }
    
    @discardableResult
    func setCornerRadius(radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        
        return self
    }
}

extension IconButton {
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
        if touchToContent(touches) {
            scaleDown()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
                self?.action?()
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
