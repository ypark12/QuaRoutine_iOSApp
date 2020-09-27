//
//  FocusHeaderVC.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Abe Park on 2020/07/23.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit

class FocusHeaderVC: UIViewController {

    
    @IBOutlet weak var bannerMessage: UILabel!
    func setStyle() {
        bannerMessage.textAlignment = .center
        bannerMessage.textColor = UIColor(named: "FontColor")
        bannerMessage.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 18)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BarColor")
        
        
        userdata = userdata.loadUserData()
        
        if userdata.banner != "" {
            bannerMessage.text = userdata.banner
        } else {
            bannerMessage.text = "Please enter the banner meesage in setting."
        }
        setStyle()
    }
    
    //reload the view when it is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
    }
}
