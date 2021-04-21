//
//  summaryViewController.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/11/21.
//

import UIKit
import MapKit

class summaryViewController: UIViewController {
    
    @IBOutlet weak var displayTime: UILabel!
    @IBOutlet weak var displayDate: UILabel!
    @IBOutlet weak var displayWorkout: UILabel!
    @IBOutlet weak var displayLocation: UILabel!
    
    var sessionInfo = session()
    var workoutList: [String] = []
    var closestGym = MKMapItem()
    
    let time = String()
    var workout = String()
    let now = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        self.displayTime.text = time
        self.displayDate.text = getDate()
        self.displayWorkout.text = workout
        self.displayLocation.text = closestGym.name
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let datetime = formatter.string(from: now)
        return datetime
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is homePage {
            let vc = segue.destination as? homePage
            
            vc?.sessionInfo = self.sessionInfo
        }
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
