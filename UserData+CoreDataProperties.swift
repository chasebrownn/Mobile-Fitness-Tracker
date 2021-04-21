//
//  UserData+CoreDataProperties.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 3/18/21.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var fullName: String?
    @NSManaged public var profilePicture: String?

}

extension UserData : Identifiable {

}
