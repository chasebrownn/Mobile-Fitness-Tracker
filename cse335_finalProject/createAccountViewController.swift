//
//  createAccountViewController.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/9/21.
//

import UIKit
import CoreData

class createAccountViewController: UIViewController {

    @IBOutlet weak var warningMsg: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var counter = 1
    var shouldSegue = false
    var fetchResults = [UserData]()
    var sessionInfo = session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCounter()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    
    @IBAction func createAccButton(_ sender: Any) {
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
            if usernameTextField.text == "" || passwordTextField.text == "" || nameTextField.text == ""
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
                
                newItem.username = usernameTextField.text!
                newItem.password = passwordTextField.text!
                newItem.fullName = nameTextField.text!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is homePage {
            let vc = segue.destination as? homePage
            
            vc?.sessionInfo = self.sessionInfo
        }
        if segue.destination is ViewController {
            let vc = segue.destination as? ViewController
            
            //vc?.
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
