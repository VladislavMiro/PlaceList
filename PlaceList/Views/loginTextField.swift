//
//  loginTextField.swift
//  PlaceList
//
//  Created by Vladislav Miroshnichenko on 23.09.2020.
//

import UIKit
@IBDesignable
class loginTextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 0.0
    @IBInspectable var leftImage: UIImage? { didSet { update() } }
    //@IBInspectable var color: UIColor = UIColor.lightGray { didSet { update() } }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    private func update() {
        
        if let image = leftImage {
            leftViewMode = ViewMode.always
            let imageView = UIImageView(frame:  CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = UIColor.gray
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
    }

}
