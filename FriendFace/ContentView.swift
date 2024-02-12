//
//  ContentView.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\User.isActive, order: .reverse),
        SortDescriptor(\User.name)
    ]) var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    CustomListView(user: user)
                }
                .padding(-4)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Friends")
            .preferredColorScheme(.dark)
            .task {
                if users.isEmpty {
                    await loadData()
                }
            }
        }
        
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([User].self, from: data)
            
            for user in decodedResponse {
                modelContext.insert(user)
            }
        } catch {
            print("Error loading data: \(error.localizedDescription)")
        }
    }
}

// This allows the query to work on booleans
extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        !lhs && rhs
    }
}


#Preview {
    ContentView()
}
