//
//  DataGridCell.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

class DataGridCell: UICollectionViewCell {
    
    static let identifier: String = "identifier_datagird_cell"
    
    var idLabel: SubHeading!
    var dateLabel: Body!
    var imageView : UIImageView!
    
    var data: DBDataObj! {
        didSet {
            idLabel.text = data.id
            
            if let date = data.date{
                dateLabel.text = date
            }else{
                dateLabel.text = "<No Date>"
            }
            
            if let data = data.data{
                imageView.loadImageUsingCache(withUrl: data, defaultImage:
                    UIImage(named: "default_image.png"))
            }else{
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(named: "default_image.png")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DataGridCell{
    
    func configureUI() {
        self.contentView.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(imageView)
        
        let vStack = UIStackView()
        self.contentView.addSubview(vStack)
        
        idLabel = SubHeading()
        dateLabel = Body()
        
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.alignment = .fill
        vStack.spacing = 2
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.addArrangedSubview(idLabel)
        vStack.addArrangedSubview(dateLabel)
        
        vStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.bottom.equalTo(vStack.snp.top).offset(-8)
        }
        
        self.contentView.layoutIfNeeded()
    }

}
