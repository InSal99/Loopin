//
//  GaugeCounter.swift
//  Loopin
//
//  Created by Celine Margaretha on 12/01/24.
//

import Foundation
struct GaugeCounter {
    static func getMultiplierValueInStitch(width: Double, sample: Gauges) -> Int {
         return Int(ceil(width / sample.width))
     }
    static func getMultiplierValueInRow(length: Double, sample: Gauges) -> Int {
         return Int(ceil(length / sample.length))
     }
     
    static func calculateStitch(width: Double, sample: Gauges) -> Int {
         return Int(ceil(width / sample.width)) * sample.stitch

     }
    static func calculateRow(length: Double, sample: Gauges) -> Int {
         return Int(ceil(length / sample.length)) * sample.row
     }
}
