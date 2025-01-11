//
//  CollectionViewCell.swift
//  ScanQR
//
//  Created by MacV on 05/01/22.
//

import Foundation
import UIKit
let propWidth = (UIScreen.main.bounds.width / 4) - 20
let propHeight = UIScreen.main.bounds.height
class MyCollectionViewCell: UICollectionViewCell {
    let itemImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? propWidth * 0.12 : 10)
        label.textColor = UIColor.black
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
        addSubview(itemImageView)
        addSubview(title)
        itemImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10).isActive = true
        itemImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -20 : -10).isActive = true
        itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 10 : 5).isActive = true
        itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -(propWidth * 0.25) : -(propWidth * 0.35)).isActive = true

        title.leftAnchor.constraint(equalTo: leftAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -20 : -10).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
