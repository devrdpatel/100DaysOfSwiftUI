//
//  UserView.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import SwiftUI

struct ViewDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.secondary)
            .padding(.vertical)
    }
}

struct InformationView: View {
    let user: StoredUser
    
    var body: some View {
        VStack {
            HStack {
                Text("Age:")
                Spacer()
                Text("\(user.age)")
            }
            .padding(.bottom)
            HStack {
                Text("Email:")
                Spacer()
                Text("\(user.wrappedEmail)")
            }
            .padding(.bottom)
            HStack {
                Text("Company:")
                Spacer()
                Text("\(user.wrappedCompany)")
            }
            .padding(.bottom)
            HStack {
                Text("Address:")
                Spacer()
                Text("\(user.wrappedAddress)")
            }
        }
        .bold()
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct UserView: View {
    //@ObservedObject var userData: UserData
    let user: StoredUser
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
//                    Image(systemName: "person.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geometry.size.width * 0.3)
//                        .foregroundColor(.secondary)
                    Text(user.nameInitials)
                        .font(.largeTitle)
                        .padding(50)
                        .foregroundColor(.primary)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(user.isActive ? .green : .primary, lineWidth: 5)
                        )
                        .padding(.top)
                    
                    ViewDivider()
                                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("About \(user.wrappedName)")
                                .font(.title.bold())
                                .padding(.bottom, 1)
                            Spacer()
                        }
                        Text(user.wrappedAbout)
                            .font(.subheadline)
                    }
                    
                    InformationView(user: user)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Tags")
                                .font(.headline.bold())
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(user.wrappedTags.components(separatedBy: ","), id: \.self) { tag in
                                    Text(tag)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.black, lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                    
                    ViewDivider()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Friends")
                                .font(.title.bold())
                                .padding(.bottom, 1)
                            Spacer()
                        }
                        
                        ForEach(user.friendsArray) { friend in
                            Text(friend.wrappedName)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(user: User(id: "aj1kda1", isActive: true, name: "Jacob Harling", age: 23, company: "Amazon", email: "harling@gmail.com", address: "1503 Swift rd", about: "Lorum ipsum oreom Lorum ipsum oreom Lorum ipsum oreom Lorum ipsum oreom Lorum ipsum oreom", registered: Date.now, tags: ["tag1", "tag2", "tag3"], friends: []))
//    }
//}
