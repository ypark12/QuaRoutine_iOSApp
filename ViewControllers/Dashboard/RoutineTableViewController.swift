//
//  RoutineTableViewController.swift
//  Productivity
//
//  Created by Diego Griese on 7/10/2020
//  Copyright © 2020 Diego. All rights reserved.
//

import UIKit
import os.log

class RoutineTableViewController: UITableViewController {

    //MARK: Properties
    
    var routines = [Routine]()
    
    var now = NSDate()
    var lastopen = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem

        // Load any saved routines
        routines = loadRoutines() ?? [Routine]()
        
        //Set times and check streaks
        lastopen = loadTime()
        
        
        if dateCheck(now: now, lastopen:lastopen) {
            streakUpdate()
        } else {
            now = lastopen
        }
        saveTime()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RoutineTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RoutineTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RoutineTableViewCell.")
        }

        // Fetches the appropriate routine for the data source layout.
        let routine = routines[indexPath.row]

        cell.nameLabel.text = routine.name
        cell.streakLabel.text = "Days: \(routine.streak)"

        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            routines.remove(at: indexPath.row)
            saveRoutines()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)

        switch(segue.identifier ?? "") {

        case "AddItem":
            os_log("Adding a new routine.", log: OSLog.default, type: .debug)

        case "ShowDetail":
            guard let routineDetailViewController = segue.destination as? RoutineViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedRoutineCell = sender as? RoutineTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "unknownSender")")
            }

            guard let indexPath = tableView.indexPath(for: selectedRoutineCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            let selectedRoutine = routines[indexPath.row]
            routineDetailViewController.routine = selectedRoutine

        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "unknownIdentifier")")
        }
    }


    //MARK: Actions

    @IBAction func unwindToRoutineList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RoutineViewController, let routine = sourceViewController.routine {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing routine.
                routines[selectedIndexPath.row] = routine
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new routine.
                let newIndexPath = IndexPath(row: routines.count, section: 0)

                routines.append(routine)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

            // Save the routines.
            saveRoutines()
        }
    }

    //MARK: Private Methods
    private func saveRoutines() {

        let fullPath = getDocumentsDirectory().appendingPathComponent("routines")

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: routines, requiringSecureCoding: false)
            try data.write(to: fullPath)
            os_log("Routines successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save routines...", log: OSLog.default, type: .error)
        }
    }
    
    private func saveTime() {
        
        let fullPath = getDocumentsDirectory().appendingPathComponent("time")

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: now, requiringSecureCoding: false)
            try data.write(to: fullPath)
            os_log("time successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save time...", log: OSLog.default, type: .error)
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func loadRoutines() -> [Routine]? {
        let fullPath = getDocumentsDirectory().appendingPathComponent("routines")
        if let nsData = NSData(contentsOf: fullPath) {
            do {

                let data = Data(referencing:nsData)

                if let loadedRoutines = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Routine> {
                    return loadedRoutines
                }
            } catch {
                print("Couldn't read file.")
                return nil
            }
        }
        print("nothing found")
        return nil
    }
    
    private func loadTime() -> NSDate {
        let fullPath = getDocumentsDirectory().appendingPathComponent("time")
        if let nsData = NSData(contentsOf: fullPath) {
            do {

                let data = Data(referencing:nsData)

                if let loadedTime = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSDate {
                    return loadedTime
                }
            } catch {
                print("Couldn't read file.")
                return NSDate()
            }
        }
        print("nothing found")
        return NSDate()
    }
    
    private func streakUpdate()
    {
        //Add code for the timer to check this
        for routine in routines {
            if routine.completed {
                routine.streak = routine.streak + 1
                routine.completed = false
            } else {
                routine.streak = 0
            }
        }
    }
    
    private func dateCheck(now: NSDate, lastopen: NSDate) -> Bool{
        print(lastopen.timeIntervalSince(now as Date))
        return lastopen.timeIntervalSince(now as Date) <= -86400
    }

}
