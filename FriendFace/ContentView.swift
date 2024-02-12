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
    
    // Sort by online status
    // Then by name
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
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        deleteUser(user)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("FriendFace")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .task {
                // Only pull data from API is nothing is saved
                // That way it works offline (challenge requirement)
                if users.isEmpty {
                    await loadData()
                }
            }
            .refreshable {
                Task {
                    await loadData()
                }
            }
        }
    }
    
    // Pull data from API and store in SwiftData
    func loadData() async {
        // Delete stored data
        try? modelContext.delete(model: User.self)
        
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
    
    func deleteUser(_ user: User) {
        modelContext.delete(user)
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
