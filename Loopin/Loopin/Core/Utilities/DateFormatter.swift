//
//  DateFormatter.swift
//  Loopin
//
//  Created by Celine Margaretha on 29/12/23.
//

import Foundation

extension Date {
    func formattedDateWithTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        
        let formattedDate = dateFormatter.string(from: self)
        
        return formattedDate
    }
}
