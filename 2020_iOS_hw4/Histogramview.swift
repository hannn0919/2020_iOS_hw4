//
//  Histogramview.swift
//  2020_iOS_hw4
//
//  Created by Hannn on 2020/5/18.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct Histogramview: View {
    var countType = [Int]()
    var percent:[CGFloat] = [0, 0, 0, 0]
    var label:[Int] = [0, 0, 0, 0]
    var max:CGFloat = 0
    var total:CGFloat = 0
    let types = ["作業", "考試", "複習", "假裝認真"]
    
    init(countType: [Int]) {
        for myTime in countType {
            if CGFloat(myTime) > max {
                max = CGFloat(myTime)
            }
            total += CGFloat(myTime)
        }
        
        for i in 0 ..< countType.count{
            label[i] = countType[i]
            percent[i] = CGFloat(CGFloat(countType[i]) / total)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack (alignment: .bottom){
                VStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(
                            width: 25, height: 300 * percent[0])
                    Text("\(label[0])")
                    Text(types[0]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(
                            width: 25, height: 300 * percent[1])
                    Text("\(label[1])")
                    Text(types[1]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(
                            width: 25, height: 300 * percent[2])
                    Text("\(label[2])")
                    Text(types[2]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(
                            width: 25, height: 300 * percent[3])
                    Text("\(label[3])")
                    Text(types[3]).font(.caption)
                }
                
            }
            Spacer()
        }
    }
}

struct Histogramview_Previews: PreviewProvider {
    static var previews: some View {
        Histogramview(countType: [10, 5, 6, 7])
    }
}
