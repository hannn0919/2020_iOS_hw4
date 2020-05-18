//
//  MyTimeEditor.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/17.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct MyTimeEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var myTimesData: MyTimeData
    @State private var name = ""
    @State private var course = ""
    @State private var type = ""
    @State private var date = Date()
    @State private var time = 0
    @State private var isDone = false
    var editMyTime: MyTime?

    let courses = ["編譯器", "光與色彩(通識)", "人工智慧", "iOS", "專題", "Android", "其他"]
    let types = ["作業", "考試", "複習", "假裝認真"]
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()

    
    var body: some View {
        
            Form {
                TextField("名稱", text: $name)
                
                DatePicker("日期", selection: $date, in: ...Date(), displayedComponents: .date)
                
                VStack(alignment: .leading) {
                    Text("科目")
                    Picker("科目", selection: $course) {
                        ForEach(courses, id: \.self) { (course) in
                            Text(course)
                        }
                    }
                    .padding()
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                }
                
                HStack {
                    Text("類別")
                    Picker("類別", selection: $type) {
                        ForEach(types, id: \.self) { (type)in
                            Text(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Stepper("花費時間 : \(time)", value: $time, in: 0...24)
                Toggle("完成", isOn: $isDone)
            }
            .navigationBarTitle("新增項目", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                
                let myTime = MyTime(name: self.name, course: self.course, type: self.type, date: self.dateFormatter.string(from: self.date), time: self.time, isDone: self.isDone)
                
                if let editMyTime = self.editMyTime {
                    let index = self.myTimesData.myTimes.firstIndex {
                        $0.id == editMyTime.id
                    }!
                    self.myTimesData.myTimes[index] = myTime
                } else {
                    self.myTimesData.myTimes.insert(myTime, at: 0)
                }

                
                self.presentationMode.wrappedValue.dismiss()
            })
                .onAppear {
                    
                    if let editMyTime = self.editMyTime {
                        self.name = editMyTime.name
                        self.course = editMyTime.course
                        self.type = editMyTime.type
                        self.date = self.dateFormatter.date(from:editMyTime.date)!
                        self.time = editMyTime.time
                        self.isDone = editMyTime.isDone
                    }
        }
        
    }

}

struct LoverEditor_Previews: PreviewProvider {
    static var previews: some View {
        MyTimeEditor(myTimesData: MyTimeData())
    }
}

