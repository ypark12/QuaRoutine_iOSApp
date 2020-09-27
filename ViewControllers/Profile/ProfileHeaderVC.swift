//
//  ProfileHeaderViewController.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Abe Park on 2020/07/22.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit

class ProfileHeaderVC: UIViewController {

    let titleLabel = HeaderLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BarColor")
        titleLabel.text = "Profile"
        addConstraints()
    }

    // Storyboard purpose
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addConstraints() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
