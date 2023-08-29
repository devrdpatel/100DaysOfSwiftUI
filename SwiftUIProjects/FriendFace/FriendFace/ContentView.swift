//
//  ContentView.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<StoredUser>
    
    //@StateObject var userData = UserData()
    @State private var searchText = ""
    @State private var attemptedDataFetch = false
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    UserView(user: user)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                            Text(user.isActive ? "Active" : "Inactive")
                                .font(.caption)
                                .foregroundColor(user.isActive ? .green : .secondary)
                        }
                        Spacer()

                        Text(user.nameInitials)
                            .bold()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .frame(minWidth: 60)
                            .background(user.isActive ? .green : .secondary)
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom)
            }
            .searchable(text: $searchText, prompt: "Look for someone")
            .navigationTitle("FriendBase")
            .task {
                //await fetchData()
                print("No internet connection?")
            }
            .toolbar {
                Button("Sort") {
                    // Add sort options
                }
            }
        }
    }
    
//    var filteredUsers: FetchedResults<StoredUser> {
//        if searchText.isEmpty {
//            return users
//        } else {
//             return users.filter { $0.wrappedName.contains(searchText) }
//        }
//    }
    
    func fetchData() async {
        guard attemptedDataFetch == false else { return }
        
        attemptedDataFetch = true
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decoded = try? decoder.decode([User].self, from: data) {
                let users = decoded
                print("Data Fetched")
                
                await MainActor.run {
                    print("Attempting to save Data")
                    saveData(with: users)
                }
            }
        } catch {
            print("Invalid Data")
        }
    }
    
    func saveData(with fetchedUsers: [User]) {
        for user in fetchedUsers {
            let newUser = StoredUser(context: moc)
            newUser.id = user.id
            newUser.name = user.name
            newUser.isActive = user.isActive
            
            newUser.age = Int16(user.age)
            newUser.company = user.company
            newUser.email = user.email
            newUser.address = user.address
            
            newUser.about = user.about
            newUser.registered = user.registered
            newUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let newFriend = StoredFriend(context: moc)
                newFriend.name = friend.name
                newFriend.id = friend.id
                newUser.addToFriends(newFriend)
                //newFriend.originUser = newUser
            }
        }
        if moc.hasChanges {
            try? moc.save()
            print("Data Saved")
        }
    }
    
//    func loadData() {
//        for user in users {
//            var newUser = User(id: user.wrappedId, isActive: user.isActive, name: user.wrappedName, age: Int(user.age), company: user.wrappedCompany, email: user.wrappedEmail, address: user.wrappedAddress, about: user.wrappedAbout, registered: user.wrappedRegistered, tags: user.wrappedTags.components(separatedBy: ","), friends: [])
//
//            for friend in user.friendsArray {
//                newUser.friends.append(Friend(id: friend.wrappedId, name: friend.wrappedName))
//            }
//            userData.users.append(newUser)
//        }
//    }
    
    func deleteData() {
        for user in users {
            moc.delete(user)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
