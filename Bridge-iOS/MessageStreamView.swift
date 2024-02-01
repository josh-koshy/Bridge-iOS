//
//  MessageStreamView.swift
//  Bridge-iOS
//
//  Created by Josh Koshy on 2/1/24.
//

import SwiftUI

struct MessageStreamView: View {
    @StateObject private var userAuthManager = UserAuthManager()
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var navigateToSignIn = false
    @State private var viewSelector = false
    var users: [User] = [
        User.init(name: "Sample", email: "javatw@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "mikec@syr.edu", yearOfGraduation: 2026, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "mikec@syr.edu", yearOfGraduation: 2026, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "mikec@syr.edu", yearOfGraduation: 2026, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "mikec@syr.edu", yearOfGraduation: 2026, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "mikec@syr.edu", yearOfGraduation: 2026, attendanceStreak: 4),
        User.init(name: "Sample", email: "chrisd@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4),
        User.init(name: "Sample", email: "ryliem@syr.edu", yearOfGraduation: 2025, attendanceStreak: 4)
    ]
    @State private var selectedUser: User?
    @State private var showingDetail = false
    
    var body: some View {
        VStack {
            
            Spacer()
            Text("Total Users: 20")
            ForEach(users.prefix(1)) { user in
                UserView(user: user)
            }
            
            
            
            
            ScrollView {
                ForEach(users, id: \.id) { user in
                    Button(action: {
                        self.selectedUser = user
                        self.showingDetail = true
                    }) {
                        VStack(alignment: .leading) {
                            Text(user.name).font(.headline)
                            Text(user.email).font(.subheadline)
                            Divider()
                        }
                        .padding(.vertical, 5)
                    }
                }
            }            .padding()
        }.sheet(isPresented: $showingDetail) {
            if let selectedUser = selectedUser {
                UserDetail(user: selectedUser)
            }
        }
    }
}

#Preview {
    MessageStreamView()
}
