//
//  ProfileContentVC.swift
//  200721_QuarantineAppStoryboard
//
//  Created by Diego Griese on 2020/07/23.
//  Copyright © 2020 Tufts University Student. All rights reserved.
//

import UIKit
import MessageUI
import os.log

//The user data
var userdata = UserData()

class ProfileContentVC: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    
    //MARK: Properties
    
    //Array of strings representing recipients
    let recipients = ["yangsun.park@tufts.edu"]
    
    //Text boxes
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var bannerBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Handle textfield user input
        nameBox.delegate = self
        bannerBox.delegate = self
        
        //Initialize UserData from save
        userdata = loadUserData()
        
        fillTextBoxes()
    }
    
    
    //MARK: SavingTextFieldInput
    
    /* I am kind of using a duct tape solution here... basically, each box has two methods: 1 where the user presses enter, and one where the user just leaves the text box (maybe via pressing off screen somewhere).  Each call edits the userdata, saves it, and removes the keyboard from the screen.*/
    
    //Name
    @IBAction func nameReturn(_ sender: Any) {
        nameBox.resignFirstResponder()
        userdata.name = nameBox.text ?? ""
        saveUserData()
    }
    
    @IBAction func nameEdited(_ sender: Any) {
        nameBox.resignFirstResponder()
        userdata.name = nameBox.text ?? ""
        saveUserData()
    }
    
    //Banner
    @IBAction func bannerReturn(_ sender: Any) {
        bannerBox.resignFirstResponder()
        userdata.banner = bannerBox.text ?? ""
        saveUserData()
    }
    
    @IBAction func bannerEdited(_ sender: Any) {
        bannerBox.resignFirstResponder()
        userdata.banner = bannerBox.text ?? ""
        saveUserData()
    }
    
    //Dismissing the keyboard when a user taps outside of the textbox and onto the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //MARK: Testing Actions
    @IBAction func printUserData(_ sender: UIButton) {
        print(userdata.name)
        print(userdata.banner)
        print("done!")
    }
    
    @IBAction func resetUserData(_ sender: Any) {
        userdata = UserData(name: nil, banner: nil)
        saveUserData()
        fillTextBoxes()
    }
    
    //MARK: Private Methods
    private func saveUserData() {
        let fullPath = getDocumentsDirectory().appendingPathComponent("userdata")
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: userdata, requiringSecureCoding: false)
            try data.write(to: fullPath)
            os_log("Userdata successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save userdata...", log: OSLog.default, type: .error)
        }
    }
    
    //Get a viable saving path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func loadUserData() -> UserData {
        let fullPath = getDocumentsDirectory().appendingPathComponent("userdata")
        if let nsData = NSData(contentsOf: fullPath) {
            do {
                
                let data = Data(referencing:nsData)
                
                if let userdata = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserData {
                    print ("returning userdata")
                    return userdata
                }
            } catch {
                print("Couldn't read file.")
                return UserData(name: nil, banner: nil)
            }
        }
        print("returning empty")
        return UserData(name: nil, banner: nil)
    }
    
    //Fill Textboxes with "insert" prompts if empty
    func fillTextBoxes(){
        //If userdata is still new, initialize textboxes with text in them.
        if userdata.name != ""{
            nameBox.text = userdata.name
        }
        
        if userdata.banner != ""{
            bannerBox.text = userdata.banner
        }
    }
    
    //MARK: Actions
    @IBAction func sendMail(_ sender: UIButton) {
        //Send the mail
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        
        mail.setCcRecipients(recipients)
        
        mail.setSubject("Feedback")
        
        present(mail, animated: true, completion: nil)
    }
    
    //MARK: MFMailComposeViewControllerDelegate Methods
    
    //1
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    //2
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
