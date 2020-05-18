//
//  MyTimeData.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/17.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation
import Combine

class MyTimeData: ObservableObject {
    @Published var myTimes = [MyTime]()
    var cancellable: AnyCancellable?
    
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: "myTimes") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([MyTime].self, from: data) {
                myTimes = decodedData
            }
        }
        
        
        cancellable = $myTimes
            .sink { (value) in
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(value)
                    UserDefaults.standard.set(data, forKey: "myTimes")
                } catch {
                    
                }
        }
        
    }
}
