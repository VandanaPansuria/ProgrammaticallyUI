//
//  BookingCell.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import UIKit

class BookingCell: UITableViewCell {
    // MARK:- Variable Declaration
    let bookingDetailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let storeViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let storeNameViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let storeNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderPlacedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        return img
    }()
    let bookingEdit:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    static let identifier = String(describing: BookingCell.self)
    
    // MARK:- Common Methods
    func configureData(bookingInfo: BookingModel) {
        iconImageView.image = UIImage(named: "")
        storeNameLabel.text = bookingInfo.storeName
        timeLabel.text = "\(bookingInfo.time)"
        orderPlacedLabel.text = "Order ID : \(bookingInfo.orderPlaced)"
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(bookingDetailViewContainer)
        
        bookingDetailViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        bookingDetailViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        bookingDetailViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        bookingDetailViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        bookingDetailViewContainer.addArrangedSubview(iconImageView)
        bookingDetailViewContainer.addArrangedSubview(storeViewContainer)
        storeViewContainer.addArrangedSubview(storeNameViewContainer)
        
        storeNameViewContainer.addArrangedSubview(storeNameLabel)
        storeNameViewContainer.addArrangedSubview(bookingEdit)
        
        storeViewContainer.addArrangedSubview(timeLabel)
        storeViewContainer.addArrangedSubview(orderPlacedLabel)
       // storeViewContainer.addArrangedSubview(dayLabel)
        
        
        bookingEdit.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        bookingEdit.setTitle("Edit", for: .normal)
        
        iconImageView.backgroundColor = .lightGray
        iconImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        iconImageView.aspectRation(1.0/1.0).isActive = true
        iconImageView.topAnchor.constraint(equalTo: bookingDetailViewContainer.topAnchor, constant: 10).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: bookingDetailViewContainer.bottomAnchor, constant: -10).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: bookingDetailViewContainer.leadingAnchor, constant: 10).isActive = true
       
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
