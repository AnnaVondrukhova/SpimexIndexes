//
//  UIView+Scale.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 29.03.2023.
//

import UIKit

extension UIView {
    @objc func scaleDown(_ active: Bool = true, scale: CGFloat = 0.95, alpha: CGFloat = 0.8) {
        let _isScale = (self.layer.transform.m11 == CATransform3DMakeScale(scale, scale, scale).m11)
        guard active != _isScale else { return }
        
        UIView.animate(withDuration: 0.15) {
            if active {
                self.layer.transform = CATransform3DMakeScale(scale, scale, scale)
                self.alpha = alpha
            } else {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.alpha = 1
            }
        }
    }
}
