//
//  FTaskTableViewCell.swift
//  Quaroutine
//
//  Created by Addison Mirliani on 6/30/20.
//  Copyright © 2020 Addison Mirliani. All rights reserved.
//

import UIKit

var currentSection: Int?

var currentRow: Int?

class FTaskTableViewCell: UITableViewCell {
    
    //MARK:- Properties
    //    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var arrowExpand: UIImageView!
    
    var sectionNumber: Int?
    
    var rowNumber: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.timerButton.addTarget(self, action: #selector(timerButtonTapped(_:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        arrowExpand.image = UIImage(named: "arrowDownIcon")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func timerButtonTapped(_ sender: UIButton){
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton){
        
        //Add another subtask to the bottom with no name
        let toAdd = FTask(name: "New Subtask", time: 0)
        subtaskListData[sectionNumber ?? 0].subtasks.append(toAdd!)
        
        //Post a notification to refresh the list
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
    }
}

