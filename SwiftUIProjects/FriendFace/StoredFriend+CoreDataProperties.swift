//
//  StoredFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Dev Patel on 6/27/23.
//
//

import Foundation
import CoreData


extension StoredFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredFriend> {
        return NSFetchRequest<StoredFriend>(entityName: "StoredFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var originUser: NSSet?

}

// MARK: Generated accessors for originUser
extension StoredFriend {

    @objc(addOriginUserObject:)
    @NSManaged public func addToOriginUser(_ value: StoredUser)

    @objc(removeOriginUserObject:)
    @NSManaged public func removeFromOriginUser(_ value: StoredUser)

    @objc(addOriginUser:)
    @NSManaged public func addToOriginUser(_ values: NSSet)

    @objc(removeOriginUser:)
    @NSManaged public func removeFromOriginUser(_ values: NSSet)

    public var wrappedId: String {
        id ?? "Unknown Id"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Friend"
    }
}

extension StoredFriend : Identifiable {

}
