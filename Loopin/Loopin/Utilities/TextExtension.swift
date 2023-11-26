//
//  FontExtension.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import Foundation
import SwiftUI

extension Text {
    func titleStyle() -> some View {
        self.font(.outfit(.bold, size: .body1))
    }
}

extension Font {
    enum FontType: String {
        case thin = "Outfit-Thin"
        case extraLight = "Outfit-ExtraLight"
        case ligth = "Outfit-Light"
        case regular = "Outfit-Regular"
        case medium = "Outfit-Medium"
        case semiBold = "Outfit-SemiBold"
        case bold = "Outfit-Bold"
        case extraBold = "Outfit-ExtraBold"
        case black = "Outfit-Black"
    }
    
    enum FontSize: CGFloat {
        case heading1 = 48.00
        case heading2 = 36.00
        case heading3 = 32.00
        case body1 = 24.00
        case body2 = 16.00
        case body3 = 20.00
        case label1 = 14.00
        case label2 = 12.00
    }
    
    static func outfit(_ font: FontType, size: FontSize) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.rawValue, size: size.rawValue)
    }
}
