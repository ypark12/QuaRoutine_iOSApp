//
//  HeaderLabel.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Abe Park on 2020/07/23.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit

class HeaderLabel: UILabel {
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
        textAlignment = .center
        textColor = UIColor(named: "FontColor")
        font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 24)
    }
}
