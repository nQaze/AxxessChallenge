//
//  ViewUtilities.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 14/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

extension UIView{
    
    func roundWithRadius(_ radius: Double){
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
    }
    
    func dropShadow(color: UIColor, radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.5
    }
    
    func round(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
