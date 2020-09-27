//
//  ProfileTextField.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Abe Park on 2020/07/26.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit

class PCTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    // Storyboard purpose
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField() {
        setStyle()
        addTopBorder(with: UIColor.separator, andWidth: 0.5)
        addBottomBorder(with: UIColor.separator, andWidth: 0.5)
    }
    
    private func setStyle() {
        textAlignment = .left
        textColor = UIColor.lightGray
        font = UIFont.systemFont(ofSize: 14)
        backgroundColor = UIColor(named: "BarColor")
        borderStyle = .none
    }
    
    // Add borders
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    // Set padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15))
    }
}
