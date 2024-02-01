//
//  UserView.swift
//  Bridge-iOS
//
//  Created by Josh Koshy on 2/1/24.
//

import SwiftUI

struct UserView: View {
    var user: User
    @State private var showDetails = false

    var body: some View {
        Button(action: {
            withAnimation {
                showDetails.toggle()
            }
        }) {
            VStack(alignment: .leading, spacing: 10) {
                Text(user.name).font(.headline)
                Text(user.email).font(.subheadline)
                Text("Graduation: \(user.yearOfGraduation)").font(.subheadline)
                Text("Attendance streak: \(user.attendanceStreak)").font(.subheadline)
                
                if showDetails {
                    // Show more detailed information here
                    Text("More details about \(user.name)...")
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        
    }
}


#Preview {
    UserView(user: User(name: "Sample", email: "sample@sample.com", yearOfGraduation: 2022, attendanceStreak: 4))
}

