//
//  CollectionViewCell.swift
//  DesignOfPages
//
//  Created by MacV on 24/12/21.
//

import Foundation
import UIKit
class MyCollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    func addViews(){
       // backgroundColor = UIColor.black
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
