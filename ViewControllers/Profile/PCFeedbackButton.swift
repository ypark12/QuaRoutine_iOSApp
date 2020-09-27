//
//  ProfileFeedbackButton.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Abe Park on 2020/07/26.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit

class PCFeedbackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    // Storyboard purpose
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setStyle()
        addTopBorder(with: UIColor.separator, andWidth: 0.5)
        addBottomBorder(with: UIColor.separator, andWidth: 0.5)
    }
    
    func setStyle() {
        contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        backgroundColor = UIColor(named: "BarColor")
        setTitle("Email us suggestions about the app.", for: .normal)
        setTitleColor(UIColor.lightGray, for: .normal)
        
        // Set padding
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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
}
