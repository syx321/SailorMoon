//
//  Extension.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/16.
//

import UIKit

class TextField: UITextField {
    var insetX: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }
    var insetY: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}

