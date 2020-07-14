//
//  Fonts.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 14/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

enum Font {
    
    case light
    case regular
    case semiBold
    case bold
    case heavy
    
    func withSize(_ size: CGFloat) -> UIFont {
        
        switch self {
        case .light:
            return UIFont(name: lightFontName, size: size)!
        case .regular:
            return UIFont(name: regularFontName, size: size)!
        case .semiBold:
            return UIFont(name: semiBoldFontName, size: size)!
        case .bold:
            return UIFont(name: boldFontName, size: size)!
        case .heavy:
            return UIFont(name: heavyFontName, size: size)!
        }
    }
}
