//
//  TableViewCell.swift
//  UItest
//
//  Created by MacV on 9/24/21.
//

import Foundation
import UIKit
class myTableViewCell: UITableViewCell {
    
    var health:Health? {
        didSet {
            guard let healthItem = health else {return}
            if let itemname = healthItem.itemname {
                profileImageView.image = UIImage(named: itemname)
                profileImageView.backgroundColor = .brown
                itemnameLabel.text = itemname
            }
            if let name = healthItem.name {
                nameDetailedLabel.text = "\(name) "
            }
            
            if let datetime = healthItem.datetime {
                datetimeView.text =  datetime
            }
            if let about = healthItem.about {
                aboutLabel.text = "\(about) "
            }
        }
    }
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let itemnameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let datetimeView:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    let aboutLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor =  .darkGray
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(itemnameLabel)
        self.contentView.addSubview(nameDetailedLabel)
        self.contentView.addSubview(aboutLabel)
        self.contentView.addSubview(datetimeView)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:10).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-10).isActive = true
        
        itemnameLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:10).isActive = true
        itemnameLabel.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:5).isActive = true
        itemnameLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10).isActive = true
        itemnameLabel.heightAnchor.constraint(equalToConstant:26).isActive = true
       
        datetimeView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        datetimeView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        datetimeView.widthAnchor.constraint(equalToConstant:120).isActive = true
        
        nameDetailedLabel.topAnchor.constraint(equalTo:self.itemnameLabel.bottomAnchor, constant: 2).isActive = true
        nameDetailedLabel.leadingAnchor.constraint(equalTo:itemnameLabel.leadingAnchor).isActive = true
        nameDetailedLabel.trailingAnchor.constraint(equalTo:self.datetimeView.leadingAnchor, constant:-5).isActive = true
        
        aboutLabel.topAnchor.constraint(equalTo:self.nameDetailedLabel.bottomAnchor, constant: 2).isActive = true
        aboutLabel.leadingAnchor.constraint(equalTo:itemnameLabel.leadingAnchor).isActive = true
        aboutLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        aboutLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-10).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
