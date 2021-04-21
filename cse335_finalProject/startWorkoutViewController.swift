//
//  startWorkoutViewController.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/9/21.
//

import UIKit
import MapKit
import Foundation

class startWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gymImg: UIImageView!
    @IBOutlet weak var workout_table: UITableView!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var gym_name: UILabel!
    @IBOutlet weak var timerVal: UILabel!
    @IBOutlet weak var show_rating: UILabel!
    
    var workoutList: [String] = []
    var rating = Double()
    var closestGym = MKMapItem()
    var newNumber = String()
    var sessionInfo = session()
    var workout = String()
    var review = getReviewBusinesses()
    
    let clientID = "ATpSNw7Ob8RNGwRtJH7ERw"
    let apiKey = "224tnYd_hswhBp8i4hE4qNacw3OyJf7YxS7UmIXYGcJtpd6AKOIhCBhwU59pRJcd0VsWLT0h66F-XiLFYEp3i_cd2J5H7fLw5Bq7iApz8S1-xQ3R2IwbLtu-TNt3YHYx"
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (workoutList)
        print (closestGym)
        //print (closestGym.phoneNumber!)
        newNumber = getNumber(number: closestGym.phoneNumber!)
        //print (newNumber)
        
        
        
        loadFromWeb()
        
        workout_table.delegate = self
        workout_table.dataSource = self
        
        sButton.layer.cornerRadius = 6.0
        fButton.layer.cornerRadius = 8.0
        stopButton.layer.cornerRadius = 6.0
        
        // Do any additional setup after loading the view.
    }
    
    func getNumber(number: String) -> String {
        let return_this : Set<Character> =
            Set("+1234567890")
        return String(number.filter {return_this.contains($0)})
    }
    
    func loadFromWeb() {
        
        var request = URLRequest(url: URL(string: "https://api.yelp.com/v3/businesses/search/phone?phone=\(newNumber)")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer 224tnYd_hswhBp8i4hE4qNacw3OyJf7YxS7UmIXYGcJtpd6AKOIhCBhwU59pRJcd0VsWLT0h66F-XiLFYEp3i_cd2J5H7fLw5Bq7iApz8S1-xQ3R2IwbLtu-TNt3YHYx", forHTTPHeaderField: "Authorization")
         
        request.httpMethod = "GET"
         
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if (error != nil)
            {
                print(error!.localizedDescription)
            }
            var err: NSError?
            var JSON_result = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
               print("\(err!.localizedDescription)")
            }
           
            print(JSON_result)
            
            let setReview = JSON_result["businesses"]! as! NSArray
            let reviewBiz = setReview[0] as? [String: AnyObject]
            
            self.review.businesses.id = (reviewBiz!["id"]! as! String)
            self.review.businesses.alias = (reviewBiz!["alias"]! as! String)
            self.review.businesses.name = (reviewBiz!["name"]! as! String)
            self.review.businesses.image_url = (reviewBiz!["image_url"]! as! String)
            self.review.businesses.url = (reviewBiz!["url"]! as! String)
            self.review.businesses.review_count = (reviewBiz!["review_count"]! as! Int)
            self.review.businesses.rating = (reviewBiz!["rating"]! as! Double)
            
            self.rating = self.review.businesses.rating
            
            print(self.rating)
            print(self.review)
            
            let imageUrlString = self.review.businesses.image_url
            print(self.review.businesses.image_url)
            if (imageUrlString == "") {
                self.gymImg.image = UIImage(named: "eosGym.jpg")
                self.gym_name.text = self.review.businesses.name
            }
            else
            {
                //self.gym_name.text = self.review.businesses.name
                let imageUrl = URL(string: imageUrlString)!
                self.load(url: imageUrl)
            }
            
            //let setEarthQuake = JSON_result["earthquakes"]! as! NSArray
            //let earthQuake = setEarthQuake[self.index] as? [String: AnyObject]
        
            //self.date = (earthQuake!["datetime"]! as! String)
            //self.magnitude = (earthQuake!["magnitude"] as? NSNumber)!.doubleValue
            //self.depth = (earthQuake!["depth"] as? NSNumber)!.doubleValue
            //self.longitude = (earthQuake!["lng"] as? NSNumber)!.doubleValue
            //self.latitude = (earthQuake!["lat"] as? NSNumber)!.doubleValue
            //self.eqid = (earthQuake!["eqid"]! as! String)
            //self.src = (earthQuake!["src"]! as! String)
            //self.totalEarthquakes = earthQuake!.count;
            
        })
         
        task.resume()
        
        //self.navigationItem.title = closestGym.name
        
    
    }
    
    func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.gymImg.image = image
                            
                            self?.show_rating.text = "Gym Rating: \(self!.rating)"
                            self?.show_rating.textColor = UIColor.yellow
                            
                            self?.gym_name.text = self!.closestGym.name
                            self?.gym_name.textColor = UIColor.white
                            self?.gym_name.isHidden = false
                        }
                    }
                }
            }
        }

    
    @IBAction func start_button(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startWorkoutViewController.count), userInfo: nil, repeats: true)

    }
    @IBAction func stop_timer(_ sender: Any) {
        timer.invalidate()
    }
    
    
    @objc func count()
    {
        counter = counter + 1
        let hours = Int(counter) / 3600
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60
        timerVal.text = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    @IBAction func finish_button(_ sender: Any) {
        //end workout and segue
    }
    
    // MARK: -- tableView --
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workout_table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = workoutList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        
        /*
         tableView.deselectRow(at: indexPath, animated: false)
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         //change color
         cell.backgroundColor = UIColor.lightGray
         cell.accessoryType = .checkmark
         
        let alert = UIAlertController(title: "Are you done with this workout?", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Complete", style: .default, handler: { _ in
                    cell.backgroundColor = UIColor.black
                    cell.textLabel?.textColor = UIColor.blue
                    tableView.reloadRows(at: [indexPath], with: .fade)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is summaryViewController {
            let vc = segue.destination as? summaryViewController
            
            vc?.sessionInfo = self.sessionInfo
            vc?.workoutList = self.workoutList
            vc?.closestGym = self.closestGym
            vc?.workout = self.workout
        }
        if segue.destination is gymPickerViewController {
            let vc = segue.destination as? gymPickerViewController
            
            vc?.workoutList = self.workoutList
            //vc?.closestGym = self.closestGyms[selectedIndex.row]
            vc?.sessionInfo = self.sessionInfo
            vc?.workout = self.workout
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
