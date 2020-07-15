//
//  DetailsVC.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    var idLabel: Heading!
    var dataLabel: SubHeading!
    var dateLabel: Body!
    var typeLabel: Chip!
    var imageView : UIImageView!
    
    var data: DBDataObj!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setData()
    }
    
    func setData(){
        
        typeLabel.text = data.type
        idLabel.text = data.id
        
        if let date = data.date{
            dateLabel.text = "Date Created : \(date)"
        }else{
            dateLabel.text = "<No Date>"
        }
        
        switch data.type {
            case TypeEnum.text.rawValue:
                imageView.isHidden = true
                if let data = data.data{
                    let trimmed = data.trimmingCharacters(in: .whitespacesAndNewlines)
                    dataLabel.text = trimmed.isEmpty ? "<No Data Found>" : trimmed
                }else{
                    dataLabel.text = "<No Data Found>"
                }
                break
            case TypeEnum.image.rawValue:
                dataLabel.isHidden = true
                if let data = data.data{
                    imageView.loadImageUsingCache(withUrl: data, defaultImage:
                        UIImage(named: "default_image.png"))
                }else{
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = UIImage(named: "default_image.png")
                }
            default:
                break
        }
        
    }
    
    func configureUI() {
        self.view.backgroundColor = UIColor.white
        
        typeLabel = Chip()
        idLabel = Heading()
        dataLabel = SubHeading()
        dateLabel = Body()
        
        idLabel.numberOfLines = 0
        dataLabel.numberOfLines = 0
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .leading
        vStack.spacing = 12
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.addArrangedSubview(typeLabel)
        vStack.addArrangedSubview(idLabel)
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(dataLabel)
        vStack.addArrangedSubview(dateLabel)
        
        self.view.addSubview(vStack)
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        self.view.layoutIfNeeded()
    }

}
