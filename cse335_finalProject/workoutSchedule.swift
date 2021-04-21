//
//  workoutSchedule.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/9/21.
//

import Foundation

class workoutSchedule {
    var leg_workout = legs()
    var shoulder_workout = shoulders()
    var back_workout = back()
    var chest_workout = chest()
    var arm_workout = arms()
}
struct legs {
    let workoutList = [
        "Lying Leg Curls 10 x 10",
        "Leg Press 5 x 12 (feet up high)",
        "Walking Lunges 3 x 10-12",
        "Weighted Bridges 4 x 10-15 (SQUEEZE)",
        "Abductor 4 x 10",
        "Adductor 4 x 10"
    ]
}
struct shoulders {
    let workoutList = [
        "Dumbell Press 4 x 10",
        "Side Raise 5 x 10",
        "Rear Delt 3 x 10",
        "Front Raises 4 x 10",
        "Quarter Lateral Raise 4 x 15",
        "Shrugs 4 x 20 (10 front, 10 back)"
    ]
}
struct back {
    let workoutList = [
        "Pullups 4 x 15",
        "Reverse Rows 4 x 8-12",
        "One Arm Rows 4 x 5-8",
        "Lat Pull Down 3 x 10",
        "Low Row 5 x 10-12",
        "Extensions 4 x 25"
    ]
}
struct chest {
    let workoutList = [
        "Incline Barbell 5 x 5-8",
        "Landmine Press 4 x 10-12",
        "Flat Bench 4 x 10",
        "Champagnes 3 x 10-12",
        "Pec Dec Flies 4 x 12-15",
        "Pushups 4 x failure"
    ]
}
struct arms {
    let workoutList = [
        "Skull Crushers 5 x 5-8",
        "One Arm Extensions 4 x 10",
        "Cable Kickbacks 4 x 10",
        "Straight Bar Curls 5 x 5-8",
        "Dumbbell Curls 4 x 10",
        "High Cable Curls 4 x 15"
    ]
}
