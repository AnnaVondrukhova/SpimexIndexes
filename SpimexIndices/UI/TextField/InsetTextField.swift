//
//  InsetTextField.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 31.03.2023.
//

import UIKit


class InsetTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 10 {
       didSet {
         layoutIfNeeded()
       }
    }
    @IBInspectable var insetY: CGFloat = 10 {
       didSet {
         layoutIfNeeded()
       }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
}
