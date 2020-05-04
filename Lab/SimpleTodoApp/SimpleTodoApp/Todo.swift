//
//  Todo.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

let DAY_IN_SEC: Double = 86400
let HOUR_IN_SEC: Double = 3600
let MIN_IN_SEC: Double = 60

struct Todo {
    var title: String
    var todoDescription: String
    var deadline: Date
    var priority: Priority
    var isCompleted: Bool = false
}

enum Priority {
    case high, medium, low
}

var todos: [Todo] = [
    Todo(title: "English", todoDescription: "Study English(IELTS) with Speaking, Writing parts and dictation for the Listening part",
         deadline: Calendar.current.startOfDay(for: Date()).addingTimeInterval(HOUR_IN_SEC * 13), priority: .medium),
    Todo(title: "iOS Class", todoDescription: "Taking iOS Development class",
         deadline: Calendar.current.startOfDay(for: Date()).addingTimeInterval(HOUR_IN_SEC * 13 + MIN_IN_SEC * 15), priority: .medium),
    Todo(title: "Tutoring", todoDescription: "Prepare for tutoring by the Playgrounds app",
         deadline: Calendar.current.startOfDay(for: Date()).addingTimeInterval(HOUR_IN_SEC * 18), priority: .high),
    Todo(title: "Python", todoDescription: "Study Python programming",
         deadline: Calendar.current.startOfDay(for: Date()).addingTimeInterval(HOUR_IN_SEC * 21), priority: .medium),
    Todo(title: "Modern C++", todoDescription: "Study Modern C++ programming",
         deadline: Calendar.current.startOfDay(for: Date()).addingTimeInterval(HOUR_IN_SEC * 23), priority: .medium),
    Todo(title: "Fix GRUB", todoDescription: "Delete unnecessary booting list for CentOS",
         deadline: Calendar.current.startOfDay(for: Date()).addingTimeInterval(DAY_IN_SEC * 3), priority: .low)
]
