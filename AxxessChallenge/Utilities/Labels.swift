//
//  Labels.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 14/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

class Heading: UILabel {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
    
    required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
              commonInit()
          }
    
    func commonInit(){
        textColor = UIColor.black
        font = Font.bold.withSize(22)
    }
}

class SubHeading: UILabel {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
    
    required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
              commonInit()
          }
    
    func commonInit(){
        textColor = UIColor.black
        font = Font.regular.withSize(15)
    }
}

class Body: UILabel {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
    
    required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
              commonInit()
          }
    
    func commonInit(){
        textColor = UIColor.gray
        font = Font.regular.withSize(12)
    }
}
