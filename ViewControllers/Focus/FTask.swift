//
//  FTask.swift
//  Quaroutine
//
//  Created by Addison Mirliani on 6/30/20.
//  Copyright © 2020 Addison Mirliani. All rights reserved.
//

import UIKit

class FTask {
    
    //MARK:- Properties
    var name: String
    var time: Int?
    
    //MARK:- Initialization
    init?(name: String, time: Int?) {
        
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.time = time
    }
}
