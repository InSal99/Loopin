//
//  ImageConverter.swift
//  Loopin
//
//  Created by Celine Margaretha on 12/01/24.
//

import Foundation
import UIKit

extension UIImage {
    func convertToData(compressionQuality: CGFloat = 0.8) -> Data? {
        return self.jpegData(compressionQuality: compressionQuality)
    }
}
