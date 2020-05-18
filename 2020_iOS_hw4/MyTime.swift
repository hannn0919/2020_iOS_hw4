//
//  MyTime.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/17.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

struct MyTime: Identifiable, Codable {
    let id = UUID()
    var name: String
    var course: String
    var type: String
    var date: String
    var time: Int
    var isDone: Bool
}

