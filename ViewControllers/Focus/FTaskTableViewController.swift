//
//  FTaskTableViewController.swift
//  Quaroutine
//
//  Created by Addison Mirliani on 6/30/20.
//  Copyright © 2020 Addison Mirliani. All rights reserved.
//

import UIKit

struct subtaskList {
    var opened = Bool()
    var title = String()
    var subtasks = [FTask]()
}

//an array of the tasks and subtasks
var subtaskListData = [subtaskList]()

class FTaskTableViewController: UITableViewController {
    
    //MARK:- Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //have no separating lines in the table view
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //set up the subtaskListData
        guard let STask1 = FTask(name: "Sample task 1", time: nil) else {
            fatalError("Unable to instantiate FTask 1")
        }
        
        guard let STask2 = FTask(name: "Sample task 2", time: 45) else {
            fatalError("Unable to instantiate FTask 2")
        }
        
        guard let STask3 = FTask(name: "Sample task 3", time: 15) else {
            fatalError("Unable to instantiate FTask 3")
        }
        
        let subtaskListOne = [STask1, STask2, STask3]
        subtaskListData = [subtaskList(opened: false, title: "Testing one", subtasks: subtaskListOne)]
        subtaskListData.append(subtaskList(opened: false, title: "Testing another", subtasks: subtaskListOne))
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
    }
    
    // MARK: - Table view data source
    
    //set the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return subtaskListData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subtaskListData[section].opened == true {
            return subtaskListData[section].subtasks.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FTaskTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FTaskTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FTaskTableViewCell.")
        }
        
        
        //sets the text for each cell
        if indexPath.row == 0 {
            cell.taskField.text = subtaskListData[indexPath.section].title
            if subtaskListData[indexPath.section].opened {
                cell.arrowExpand.image = UIImage(named: "arrowUpIcon")
            } else {
                cell.arrowExpand.image = UIImage(named: "arrowDownIcon")
            }
            cell.arrowExpand.isHidden = false
            cell.addButton.isHidden = false
            cell.timerButton.isHidden = false
        } else {
            cell.taskField.text = subtaskListData[indexPath.section].subtasks[indexPath.row - 1].name
            cell.arrowExpand.isHidden = true
            cell.addButton.isHidden = true
            cell.timerButton.isHidden = true
        }
        cell.sectionNumber = indexPath.section
        cell.rowNumber = indexPath.row
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if indexPath.row == 0 {
                //delete the focus task and list of subtasks
                subtaskListData.remove(at: indexPath.section)
                let array = [indexPath.section]
                let indexSet = IndexSet(array)
                tableView.deleteSections(indexSet, with: UITableView.RowAnimation.fade)
            } else {
                //delete the specific subtask
                subtaskListData[indexPath.section].subtasks.remove(at: (indexPath.row - 1))
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        //this needs to stay
    }
    
    @objc func reloadTable() {
        tableView.reloadData()
    }
    
    //expands and contracts the sections of the table when the expand/contract arrow is pressed or the cell is pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if subtaskListData[indexPath.section].opened == true {
            subtaskListData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            subtaskListData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}
