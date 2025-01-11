//
//  ItemsCell.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import UIKit


class ItemsCell: UITableViewCell {
    // MARK:- Variable Declaration
    let itemsViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    let itemsDetailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    let quantityLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = String(describing: ItemsCell.self)
    
    // MARK:- Common Methods
    func configureData(itemInfo: itemsModel) {
        self.quantityLabel.text = itemInfo.quantity
        self.nameLabel.text = itemInfo.name
        self.priceLabel.text = itemInfo.price
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(itemsViewContainer)
        
        itemsViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        itemsViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        itemsViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        itemsViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -2).isActive = true
        
        itemsViewContainer.addArrangedSubview(itemsDetailViewContainer)
        itemsViewContainer.addArrangedSubview(underlineView)
        itemsDetailViewContainer.addArrangedSubview(quantityLabel)
        itemsDetailViewContainer.addArrangedSubview(nameLabel)
        itemsDetailViewContainer.addArrangedSubview(priceLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
