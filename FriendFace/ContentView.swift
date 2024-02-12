//
//  ContentView.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
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
            users = decodedResponse
        } catch {
            print("Error loading data: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView()
}
