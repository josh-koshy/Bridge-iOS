//
//  UserDetail.swift
//  Bridge-iOS
//
//  Created by Josh Koshy on 2/1/24.
//

import Foundation
import SwiftUI


struct UserDetail: View {
    var user: User
    
    var body: some View {
        List {
            Text("Name: \(user.name)")
            Text("Email: \(user.email)")
            Text("Graduation: \(user.yearOfGraduation)")
            Text("Attendance streak: \(user.attendanceStreak)")
            Text("This is an expanded detail view.")
            // Add more fields as needed
        }
    }
}
