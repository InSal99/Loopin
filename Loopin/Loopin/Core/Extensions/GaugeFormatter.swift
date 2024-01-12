//
//  GaugeCalculator.swift
//  Loopin
//
//  Created by Celine Margaretha on 12/01/24.
//

import Foundation

extension Gauges {

   mutating func updateStitch(sample: Gauges) {
       stitch = GaugeCounter.calculateStitch(width: width, sample: sample)
   }
    mutating func updateRow(sample: Gauges) {
        row =  GaugeCounter.calculateRow(length: length, sample: sample)
   }
    
}

