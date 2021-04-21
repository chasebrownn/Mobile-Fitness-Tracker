//
//  ViewController.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 3/17/21.
//

import UIKit
import CoreData

class ViewController: UIViewController  {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningMsg: UILabel!
    
    var sessionInfo = session()
    
    var full_name = String()
    var username = String()
    var password = String()
    
    var new_fullName = String()
    var shouldSegue = false
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchResults = [UserData]()
    var counter = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        printCoreData()
        initCounter()
        self.warningMsg.isHidden = true
    }
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        //let sort = NSSortDescriptor(key: "username", ascending: true)
        //fetchRequest.sortDescriptors = [sort]
        var x = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [UserData])!

        x = fetchResults.count
        
        print(x)

        // return howmany entities in the coreData
        return x
    }
    
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")
        print (counter)
        //print(fetchResults.count)
    }
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (self.shouldSegue == true)
        {
            return true
        }
        else
        {
            return false
        }
    }

    @IBAction func loginButton(_ sender: Any) { //_ sender: Any
        
        let request = NSFetchRequest<UserData>(entityName: "UserData")
        do {
            fetchResults = try self.managedObjectContext.fetch(request)
        } catch{ print("Error on fetching") }
        
        if fetchResults.count == 0
        {
            if usernameTextField.text == "" || passwordTextField.text == ""
            {
                self.warningMsg.text = "Please enter login info"
                self.warningMsg.textColor = UIColor.red
                self.warningMsg.isHidden = false
                self.shouldSegue = false
                return
                
            } else {
                self.warningMsg.text = "Username not recognized. Try creating an account"
                self.warningMsg.textColor = UIColor.red
                self.warningMsg.isHidden = false
                self.shouldSegue = false
                return
            }
        }
        else
        {
            var is_match: Bool = false
            
            if usernameTextField.text == "" || passwordTextField.text == ""
            {
                self.warningMsg.text = "Please enter login info"
                self.warningMsg.textColor = UIColor.red
                self.warningMsg.isHidden = false
                self.shouldSegue = false
                return
                
            } else {
                
                for i in 0...fetchResults.count - 1 {
                    if (fetchResults[i].username == usernameTextField.text && fetchResults[i].password != passwordTextField.text)
                    {
                        self.warningMsg.text = "Password incorrect"
                        self.warningMsg.textColor = UIColor.red
                        self.warningMsg.isHidden = false
                        
                        is_match = false
                        self.shouldSegue = false
                        return
                    }
                    if (fetchResults[i].username == usernameTextField.text && fetchResults[i].password == passwordTextField.text)
                    {
                        sessionInfo.user_name = fetchResults[i].fullName!
                        sessionInfo.user_username = fetchResults[i].username!
                        sessionInfo.user_password = fetchResults[i].password!
                        sessionInfo.user_img = fetchResults[i].profilePicture!
                        
                        is_match = true
                        self.shouldSegue = true
                        break
                    }
                }
                if (is_match == false)
                {
                    self.warningMsg.text = "Username not recognized. Try creating an account"
                    self.warningMsg.textColor = UIColor.red
                    self.warningMsg.isHidden = false
                }
                else
                {
                    // segue
                }
            }
        }
    }
    
    @IBAction func createAccButton(_ sender: Any) {
        
        shouldSegue = true
        return
        
        /*
        let user_exists: Bool = findMatch()
        
        if (user_exists)
        {
            self.warningMsg.text = "Username already exists"
            self.warningMsg.textColor = UIColor.red
            self.warningMsg.isHidden = false
            
            self.shouldSegue = false
            return
        }
        else
        {
            if usernameTextField.text == "" || passwordTextField.text == ""
            {
                self.warningMsg.text = "Please enter login info"
                self.warningMsg.textColor = UIColor.red
                self.warningMsg.isHidden = false
                
                self.shouldSegue = false
                return
            }
            else
            {
                // create a new entity object
                let ent = NSEntityDescription.entity(forEntityName: "UserData", in: self.managedObjectContext)

                let newItem = UserData(entity: ent!, insertInto: self.managedObjectContext)
                
                // Show alert and allow user to input their name
                let alertController = UIAlertController(title: "Add Name", message: "", preferredStyle: .alert)
                let enter_name_action = UIAlertAction(title: "Add Info", style: .default) { (action) in
                    
                    let text = alertController.textFields!.first!.text!
                    
                    if !text.isEmpty
                    {
                        print(text)
                        self.setFullName(name: text)
                        //self.new_fullName = text
                    }
                }
                //print (new_fullName)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                
                alertController.addTextField { (textField) in
                    textField.placeholder = "Enter Full Name"
                    textField.keyboardType = .default
                }
                
                alertController.addAction(cancelAction)
                alertController.addAction(enter_name_action)
                self.present(alertController, animated: true, completion: nil)
                
                newItem.username = usernameTextField.text!
                newItem.password = passwordTextField.text!
                newItem.fullName = new_fullName // not saving name for some reason -> async method issue
                newItem.profilePicture = "defaultProfile.jpg"
                
                updateCounter()
                
                // save the updated context
                do {
                    try self.managedObjectContext.save()
                } catch _ {
                    print("Save Failed")
                }
                
                print(newItem)
                
                sessionInfo.user_name = newItem.fullName!
                sessionInfo.user_username = newItem.username!
                sessionInfo.user_password = newItem.password!
                sessionInfo.user_img = newItem.profilePicture!
                
                self.shouldSegue = true
                return
            }
        }
         */
    }
    
    func findMatch() -> Bool
    {
        let request = NSFetchRequest<UserData>(entityName: "UserData")
        do { fetchResults = try self.managedObjectContext.fetch(request) }
        catch{ print("Error on fetching") }
        
        if fetchResults.count == 0 { return false }
        
        for i in 0...fetchResults.count - 1 {
            if (fetchResults[i].username == usernameTextField.text)
            {
                return true
            }
        }
        return false
    }
    
    func printCoreData() {
        let request = NSFetchRequest<UserData>(entityName: "UserData")
        do { fetchResults = try self.managedObjectContext.fetch(request) }
        catch{ print("Error on fetching") }
        
        if fetchResults.count == 0 { return }
        
        for i in 0...fetchResults.count - 1 {
            print(fetchResults[i].fullName)
            print(fetchResults[i].username)
            print(fetchResults[i].password)
        }
    }
    
    func setFullName(name: String) {
        self.new_fullName = name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is homePage {
            let vc = segue.destination as? homePage
            
            vc?.sessionInfo = self.sessionInfo
        }
    }
    
    
}

