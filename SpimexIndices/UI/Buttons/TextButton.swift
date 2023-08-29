//
//  TextButton.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 29.03.2023.
//

import UIKit

class TextButton: UIView {
    
    var action: (() -> Void)?
    
    var stackView: UIStackView!
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.buttonBase
        label.text = "Button"
        label.textAlignment = .center
        label.isHidden = false
        label.numberOfLines = 1
        
        return label
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
        stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = Styles.Sizes.paddingMedium
        
        self.addSubview(stackView)
        stackView.centerInSuperview()
    }
}

extension TextButton {
    
    @discardableResult
    func setButtonColor(color: UIColor) -> Self {
        self.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    func setTitleColor(color: UIColor) -> Self {
        self.titleLabel.textColor = color
        
        return self
    }
    
    @discardableResult
    func setTitleFont(font: UIFont) -> Self {
        self.titleLabel.font = font
        
        return self
    }
    
    @discardableResult
    func setTitle(title: String) -> Self {
        self.titleLabel.text = title
        
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

extension TextButton {
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
