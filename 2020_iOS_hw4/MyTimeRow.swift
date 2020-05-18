//
//  MyTimeRow.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/17.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct MyTimeRow: View {
    var myTime: MyTime

    var body: some View {
        HStack {
            VStack(spacing: 10){
                Text("\(myTime.course) - \(myTime.type)")
                    .fontWeight(.heavy).padding(10)
                Text("\(myTime.date)")
                    .foregroundColor(.blue).padding(5)
            }.background(Color.yellow)
            Text("\(myTime.name)").fontWeight(.heavy).padding(10)
            Spacer()
            if(myTime.isDone == true){
                Text("\(myTime.time) 小時").font(.headline).foregroundColor(.green)
            }
            else{
                Text("\(myTime.time) 小時").font(.headline).foregroundColor(.red)
            }
        }

    }
}

struct MyTimeRow_Previews: PreviewProvider {
    static var previews: some View {
        MyTimeRow(myTime: MyTime(name: "HW4", course: "iOS", type: "作業", date: "2020/05/16", time: 5, isDone: false))
            .previewLayout(.sizeThatFits)
    }
}
