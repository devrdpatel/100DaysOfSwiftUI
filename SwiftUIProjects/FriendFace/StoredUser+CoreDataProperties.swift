//
//  StoredUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Dev Patel on 6/27/23.
//
//

import Foundation
import CoreData


extension StoredUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredUser> {
        return NSFetchRequest<StoredUser>(entityName: "StoredUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

}

// MARK: Generated accessors for friends
extension StoredUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: StoredFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: StoredFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

    public var wrappedId: String {
        id ?? "Unknown Id"
    }
    
    public var wrappedName: String {
        name ?? "Unknown User"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    public var wrappedAbout: String {
        about ?? "No information available"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedTags: String {
        tags ?? ""
    }
    
    public var friendsArray: [StoredFriend] {
        let set = friends as? Set<StoredFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var nameInitials: String {
        String(wrappedName.components(separatedBy: " ").compactMap {
            $0.first
        }).uppercased()
    }
}

extension StoredUser : Identifiable {

}
