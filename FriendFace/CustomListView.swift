//
//  CustomListView.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/11/24.
//

// Credits to trailingclosure.com
// https://trailingclosure.com/product-card-in-swiftui/

import SwiftUI

struct CustomListView: View {
    var user: User
    
    var body: some View {
        HStack() {
            Text(user.name)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundStyle(.white)
            
            Text("\(user.age)")
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundStyle(.gray)
            
            Spacer()
            
            if user.isActive {
                Circle()
                    .fill(.green)
                    .frame(width: 20, height: 20)
            } else {
                Circle()
                    .fill(.red)
                    .frame(width: 20, height: 20)
            }
            
        }
        .padding([.trailing, .vertical], 15)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .cornerRadius(10)
    }
}

#Preview {
    CustomListView(user: User(id: UUID(), isActive: true, name: "John Cena", age: 25, company: "WWE", email: "john@cena.com", address: "123 WWE Lane", about: "I like to punch people", registered: "12/12/12", tags: ["WWE", "Punch", "Strong"], friends: []))
}
