//
//  ChartView.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/17.
//  Copyright © 2020 Hannn. All rights reserved.
//


import SwiftUI

struct ChartView: View {
    @ObservedObject var myTimeData = MyTimeData()
    var totalTime: Double = 0
    var index: Double = 0
    var done: Double = 0
    var countTime: [Double] = [0, 0, 0, 0, 0, 0, 0]
    var percentTime: [Double] = [0, 0, 0, 0, 0, 0, 0]
    var countType:[Int] = [0, 0, 0, 0]
    var angles = [Angle]()
    var startDegree: Double = 0
    var rate: Double = 0
    @State private var selectChart: String = "圓餅圖"
    @State private var trimEnd: CGFloat = 0
    
    let courses = ["編譯器", "光與色彩(通識)", "人工智慧", "iOS", "專題", "Android", "其他"]
    let types = ["作業", "考試", "複習", "假裝認真"]
    let chart = ["圓餅圖", "長條圖", "甜甜圈圖"]
    
    init(myTimeData: MyTimeData) {
        for data in myTimeData.myTimes {
            index += 1;
            if(data.isDone == true){
                done += 1
            }
            totalTime += Double(data.time)
            
            for i in 0 ..< courses.count {
                if data.course == courses[i] {
                    countTime[i] += Double(data.time)
                }
            }
            
            
            for i in 0 ..< types.count {
                if data.type == types[i] {
                    countType[i] += 1
                }
            }
        }
        
        rate = done / index
        
        for i in 0 ..< courses.count {
            percentTime[i] = countTime[i] / totalTime
            print(percentTime[i])
        }
        
        for percent in percentTime {
            angles.append(.degrees(startDegree))
            startDegree += 360 * percent
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: self.$selectChart, label: Text("請選擇項目：")) {
                    ForEach(self.chart, id: \.self) {(text) in
                        Text(text)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding(20)
                
                if self.selectChart == "圓餅圖" {
                    HStack {
                        PieChartView(startAngle: angles)
                            .frame(width: 180, height: 180)
                        Spacer()
                        VStack(alignment: .trailing){
                            Group{
                                Color.red.frame(width: 10, height: 10)
                                Text("編譯器 " + String(format: "%.1f", percentTime[0] * 100) + "%")
                                Color.orange.frame(width: 10, height: 10)
                                Text("光與色彩 " + String(format: "%.1f", percentTime[1] * 100) + "%")
                                Color.yellow.frame(width: 10, height: 10)
                                Text("人工智慧 " + String(format: "%.1f", percentTime[2] * 100) + "%")
                            }
                            Color.green.frame(width: 10, height: 10)
                            Text("iOS " + String(format: "%.1f", percentTime[3] * 100) + "%")
                            Color.blue.frame(width: 10, height: 10)
                            Text("專題 " + String(format: "%.1f", percentTime[4] * 100) + "%")
                            Color.purple.frame(width: 10, height: 10)
                            Text("Android " + String(format: "%.1f", percentTime[5] * 100) + "%")
                            Color.gray.frame(width: 10, height: 10)
                            Text("其他 " + String(format: "%.1f", percentTime[6] * 100) + "%")
                        }
                    }
                    .padding()
                    
                    Text("總時間： " + String(format: "%.0f", totalTime) + " 小時")
                }
                else if self.selectChart == "長條圖" {
                    Histogramview(countType: countType)
                }
                else {
                    VStack{
                        Text("完成度：")
                            .font(.system(size: 25))
                        ZStack {
                            Text("\(rate)")
                                .font(.system(size: 33))
                            Circle()
                                .trim(from: 0, to: trimEnd)
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .frame(width: 250, height: 250)
                                .animation(.linear(duration: 0.8))
                                .onAppear {
                                    self.trimEnd = CGFloat(self.rate)
                            }
                        }
                    }
                }
                Spacer()
                
            }
            .navigationBarTitle("圖表統計")
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(myTimeData: MyTimeData())
    }
}
