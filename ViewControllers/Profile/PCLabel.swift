//
//  ProfileLabel.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Abe Park on 2020/07/26.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit

class PCLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }
    
    // Storyboard purpose
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyle()
    }
    
    func setStyle() {
        textAlignment = .left
        textColor = UIColor(named: "FontColor")
        font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)
    }
    
    // Set padding
    var topInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var leftInset: CGFloat = 10
    var rightInset: CGFloat = 0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}
