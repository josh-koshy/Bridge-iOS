//
//  User.swift
//  Bridge-iOS
//
//  Created by Josh Koshy on 2/1/24.
//
import Foundation

struct User: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var email: String
    var yearOfGraduation: Int
    var attendanceStreak: Int
    // Add more details for the extended information
}
