//
//  RoutineViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class RoutineViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var selectionControl: SelectionControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    /*
         This value is either passed by `RoutineTableViewController` in `prepare(for:sender:)`
         or constructed as part of adding a new routine.
     */
    var routine: Routine?

    //Maintain streak if there was one already.  Placeholder variable
    var streak = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self

        // Set up views if editing an existing Routine.
        if let routine = routine {
            navigationItem.title = routine.name
            nameTextField.text = routine.name
            selectionControl.selection = routine.weekdays
            streak = routine.streak
        }


    }

    //MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = nameTextField.text
    }
    

    //MARK: Navigation

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddRoutineMode = presentingViewController is UINavigationController

        if isPresentingInAddRoutineMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The RoutineViewController is not inside a navigation controller.")
        }
    }

    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)

        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = nameTextField.text ?? ""
        let selection = selectionControl.selection

        // Set the routine to be passed to RoutineTableViewController after the unwind segue.
        routine = Routine(name: name, weekdays: selection, streak: streak)
    }


}
