//
//  homePage.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 3/17/21.
//

import UIKit

class homePage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workoutTable: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let current_user = String()
    
    var sessionInfo = session()
    var workouts = workoutSchedule()
    
    var workout = String()
    
    var workoutList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.workoutList = workouts.leg_workout.workoutList
        
        print (sessionInfo)
        
        workoutTable.delegate = self
        workoutTable.dataSource = self

    }
    
    @IBAction func show_table(_ sender: Any) {
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            self.workoutList = workouts.leg_workout.workoutList
            self.workout = "legs"
        case 1:
            self.workoutList = workouts.shoulder_workout.workoutList
            self.workout = "shoulders"
        case 2:
            self.workoutList = workouts.back_workout.workoutList
            self.workout = "back"
        case 3:
            self.workoutList = workouts.chest_workout.workoutList
            self.workout = "chest"
        case 4:
            self.workoutList = workouts.arm_workout.workoutList
            self.workout = "arms"
        default:
            self.workoutList = workouts.leg_workout.workoutList
            self.workout = "legs"
        }
        
        workoutTable.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is profileViewController {
            let vc = segue.destination as? profileViewController
            
            vc?.sessionInfo = self.sessionInfo
        }
        if segue.destination is gymPickerViewController {
            let vc = segue.destination as? gymPickerViewController
            
            vc?.workoutList = self.workoutList
            vc?.sessionInfo = self.sessionInfo
            vc?.workout = self.workout
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = workoutList[indexPath.row]
        
        return cell
    }
    
    

}
