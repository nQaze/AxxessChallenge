//
//  DataTVC.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    
    static let identifier: String = "identifier_data_cell"
    
    var idLabel: Heading!
    var dataLabel: SubHeading!
    var dateLabel: Body!
    
    var data: DBDataObj! {
        didSet {
            idLabel.text = data.id
            
            if let date = data.date{
                dateLabel.text = date
            }else{
                dateLabel.text = "<No Date>"
            }
            
            if let data = data.data{
                let trimmed = data.trimmingCharacters(in: .whitespacesAndNewlines)
                dataLabel.text = trimmed.isEmpty ? "<No Data Found>" : trimmed
            }else{
                dataLabel.text = "<No Data Found>"
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension DataCell{
    
    func configureUI() {
        
        idLabel = Heading()
        dataLabel = SubHeading()
        dateLabel = Body()
        dataLabel.numberOfLines = 2
        
        var labelArray = [UILabel]()
        labelArray.append(idLabel)
        labelArray.append(dataLabel)
        labelArray.append(dateLabel)
        
        let vStack = UIStackView(arrangedSubviews: labelArray)
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.alignment = .fill
        vStack.spacing = 4
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = UIColor.blue
        lineView.snp.makeConstraints {
            $0.width.equalTo(3)
        }
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.alignment = .fill
        hStack.spacing = 12
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        hStack.addArrangedSubview(lineView)
        hStack.addArrangedSubview(vStack)
        
        self.contentView.addSubview(hStack)
        
        hStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
}

