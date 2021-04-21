//
//  getReview.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/15/21.
//

import Foundation

struct getReviewBusinesses {
    var businesses = getReviewBusiness()
}

struct getReviewBusiness {
    var id:String = ""
    var alias:String = ""
    var name:String = ""
    var image_url:String = ""
    var url:String = ""
    var review_count:Int = 0
    var rating:Double = 0.0 //Double
}
