//
//  ProgressBar.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProgressBar: View {
    var value: Int
    var maximum: Int

    var body: some View {
        Gauge(value: Double(value), in: 0...Double(maximum)) {}
        .gaugeStyle(.accessoryLinearCapacity)
        .accentColor(Color("Peach"))
        .scaleEffect(CGSize(width: 1, height: 3))
        .animation(.spring(), value: value)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 1, maximum: 3)
    }
}
