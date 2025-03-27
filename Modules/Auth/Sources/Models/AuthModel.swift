//
// AuthModel.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation
import FirebaseAuth


public struct UserModel: Encodable {

    public let uid: String
    public let name: String
    public let email: String
    public let photoURL: String?
    public let photoData: Data?
    public let age: Int?
    public let gender: UserGender?
    public let weight: Int?
    public let height: Int?
    public let usualTimeForSleep: String?
    public let usualTimeForWakeUp: String?
    public let usualSleepHoursCount: Int?
    public let scheduleConsistency: ScheduleConsistency?
    public let fallAsleepLevel: FallAsleepLevel?

    public init(
        uid: String,
        name: String,
        email: String,
        photoURL: String? = nil,
        photoData: Data? = nil,
        age: Int? = nil,
        gender: UserGender? = nil,
        weight: Int? = nil,
        height: Int? = nil,
        usualTimeForSleep: String? = nil,
        usualTimeForWakeUp: String? = nil,
        usualSleepHoursCount: Int? = nil,
        scheduleConsistency: ScheduleConsistency? = nil,
        fallAsleepLevel: FallAsleepLevel? = nil
    ) {
        self.uid = uid
        self.name = name
        self.email = email
        self.photoURL = photoURL
        self.photoData = photoData
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
        self.usualTimeForSleep = usualTimeForSleep
        self.usualTimeForWakeUp = usualTimeForWakeUp
        self.usualSleepHoursCount = usualSleepHoursCount
        self.scheduleConsistency = scheduleConsistency
        self.fallAsleepLevel = fallAsleepLevel
    }

    public enum UserGender: String, Codable {
        case male
        case female
    }

    public enum ScheduleConsistency: String, Codable {
        case veryConsistent
        case consistent
        case notConsistent
    }

    public enum FallAsleepLevel: String, Codable {
        case veryEasy
        case easy
        case medium
        case hard
        case veryHard
    }

    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case email
        case photoURL
        case age
        case gender
        case weight
        case height
        case usualTimeForSleep
        case usualTimeForWakeUp
        case usualSleepHoursCount
        case scheduleConsistency
        case fallAsleepLevel
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(uid, forKey: .uid)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(photoURL, forKey: .photoURL)
        try container.encode(age, forKey: .age)
        try container.encode(gender, forKey: .gender)
        try container.encode(weight, forKey: .weight)
        try container.encode(height, forKey: .height)
        try container.encode(usualTimeForSleep, forKey: .usualTimeForSleep)
        try container.encode(usualTimeForWakeUp, forKey: .usualTimeForWakeUp)
        try container.encode(usualSleepHoursCount, forKey: .usualSleepHoursCount)
        try container.encode(scheduleConsistency, forKey: .scheduleConsistency)
        try container.encode(fallAsleepLevel, forKey: .fallAsleepLevel)
    }
}
