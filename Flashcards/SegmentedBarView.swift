//
//  SegmentedBarView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/24/20.
//  Tutorial: https://trailingclosure.com/animated-spending-bar-using-swiftui/

import SwiftUI

struct SegmentedBarView: View {
    @Binding var values: [Double]
    @State var colors: [Color]
    
    private var totalValue: Double {
        get {
            return values.reduce(0) { (res, val) -> Double in
                return res + val
            }
        }
    }
    
    var body: some View {
        GeometryReader {geo in
            HStack(alignment: .center, spacing: 4) {
                ForEach(self.values.indices) { i in
                    Rectangle()
                        .frame(width: geo.size.width * CGFloat(self.values[i] / self.totalValue), height: nil, alignment: .center)
                        .foregroundColor(self.colors[i])
                        .cornerRadius(geo.size.height/2.0)
                        .animation(.easeInOut)
                }
            }
        }
    }
}

struct SegmentedBarView_Previews: PreviewProvider {
    @State static var values: [Double] = [500, 320]
    static var previews: some View {
        SegmentedBarView(values: $values, colors: [.green, .red])
    }
}
