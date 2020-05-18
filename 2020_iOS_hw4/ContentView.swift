//
//  ContentView.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/16.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var myTimeData = MyTimeData()
    
    var body: some View {
        TabView {
            MyTimeList(timeData: self.myTimeData)
                .tabItem {
                    Image(systemName: "dollarsign.square.fill")
                    Text("時間記錄")
            }
            
            ChartView(myTimeData: self.myTimeData)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("圖表統計")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
