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
    
    private var idLabel: Heading!
    private var dataLabel: SubHeading!
    private var dateLabel: Body!
    
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
    
    private func configureUI() {
        
        //Adding Horizontal Parent StackView
        let hStack = UIStackView()
        self.contentView.addSubview(hStack)
        
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.alignment = .fill
        hStack.spacing = 12
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        hStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        //Adding Labels to display our data
        idLabel = Heading()
        dataLabel = SubHeading()
        dateLabel = Body()
        dataLabel.numberOfLines = 2
        
        var labelArray = [UILabel]()
        labelArray.append(idLabel)
        labelArray.append(dataLabel)
        labelArray.append(dateLabel)
        
        //Adding Vertical StackView to hold our Labels
        let vStack = UIStackView(arrangedSubviews: labelArray)
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.alignment = .fill
        vStack.spacing = 4
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = Color.primaryDark
        
        hStack.addArrangedSubview(lineView)
        hStack.addArrangedSubview(vStack)
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(3)
        }
    }
    
}

