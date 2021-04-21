//
//  ReviewRequest.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/15/21.
//

import Foundation

/*
var semaphore = DispatchSemaphore (value: 0)
 
var request = URLRequest(url: URL(string: "https://api.yelp.com/v3/businesses/search/phone?phone=\(newNumber)")!,timeoutInterval: Double.infinity)
request.addValue("Bearer 224tnYd_hswhBp8i4hE4qNacw3OyJf7YxS7UmIXYGcJtpd6AKOIhCBhwU59pRJcd0VsWLT0h66F-XiLFYEp3i_cd2J5H7fLw5Bq7iApz8S1-xQ3R2IwbLtu-TNt3YHYx", forHTTPHeaderField: "Authorization")
 
request.httpMethod = "GET"
 
let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    semaphore.signal()
    return
  }
  print(String(data: data, encoding: .utf8)!)
  semaphore.signal()
}
 
task.resume()
semaphore.wait()
 */

struct ReviewRequest {
    let resourceURL:URL
    let API_KEY = "224tnYd_hswhBp8i4hE4qNacw3OyJf7YxS7UmIXYGcJtpd6AKOIhCBhwU59pRJcd0VsWLT0h66F-XiLFYEp3i_cd2J5H7fLw5Bq7iApz8S1-xQ3R2IwbLtu-TNt3YHYx"
}
