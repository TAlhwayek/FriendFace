//
//  DetailView.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/11/24.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Info") {
                    HStack {
                        Text("Age")
                            .bold()
                        Spacer()
                        Text("\(user.age)")
                    }
                    
                    HStack {
                        Text("Email")
                            .bold()
                        Spacer()
                        Text("\(user.email)")
                    }
                    
                    HStack {
                        Text("Date Joined")
                            .bold()
                        Spacer()
                        Text("\(user.fixedDate)")
                    }
                    
                    HStack {
                        Text("Address")
                            .bold()
                        Spacer()
                        Text("\(user.address)")
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Company")
                            .bold()
                        Spacer()
                        Text("\(user.company)")
                    }
                }
                
                Section ("Online Status") {
                    HStack {
                        Text(user.isActive ? "Online" : "Offline")
                            .bold()
                            .foregroundStyle(user.isActive ? .green : .red)
                    }
                }
                
                Section("Bio") {
                    Text(user.about)
                }
                
                Section("Friends") {
                    List(user.friends, id: \.id) { friend in
                        Text(friend.name)
                    }
                }
                
                Section("Tags") {
                    List(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
                
            }
            .navigationTitle(user.name)
        }
    }
}

#Preview {
    DetailView(user: User(id: UUID(), isActive: true, name: "John Cena", age: 25, company: "WWE", email: "john@cena.com", address: "123 WWE Lane", about: "I like to punch people", registered: "12/12/12", tags: ["WWE", "Punch", "Strong"], friends: []))
}
