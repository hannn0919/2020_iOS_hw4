//
//  MyTimeList.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/17.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct MyTimeList: View {
    
    @ObservedObject var timeData = MyTimeData()
    @State private var showEditMyTime = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(timeData.myTimes) { (mytime) in
                    NavigationLink(destination: MyTimeEditor(myTimesData: self.timeData, editMyTime: mytime)) {
                        MyTimeRow(myTime: mytime)

                    }
                    
                }
                .onDelete { (indexSet) in
                    self.timeData.myTimes.remove(atOffsets: indexSet)
                }
                .onMove { (indexSet, index) in
                    self.timeData.myTimes.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .navigationBarTitle("時間列表")
            .navigationBarItems(leading: EditButton() , trailing: Button(action: {
                self.showEditMyTime = true
            }) {
                Image(systemName: "plus.circle.fill")
            })
                .sheet(isPresented: $showEditMyTime) {
                    NavigationView {
                        MyTimeEditor(myTimesData: self.timeData)

                    }
            }
        }
    }
}

struct MyTimeList_Previews: PreviewProvider {
    static var previews: some View {
        MyTimeList()
    }
}
