//
//  AllTableViewCell.swift
//  DesignOfPages
//
//  Created by MacV on 24/12/21.
//

import Foundation
import UIKit
class OrderCell: UITableViewCell {
    // MARK:- Variable Declaration
    let OrderDetailViewContainer: UIStackView = {
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
    let orderPlacedLabel:UILabel = {
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
    let status:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let payment:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let OrderEdit:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    static let identifier = String(describing: OrderCell.self)
    
    // MARK:- Common Methods
    func configureData(OrderInfo: OrderModel) {
        storeNameLabel.text = "\(OrderInfo.tableName) : \t \(OrderInfo.items) \t 11QR"
        orderPlacedLabel.text = "Order Placed : \(OrderInfo.orderPlaced)"
        timeLabel.text = "Time Lapsed : \(OrderInfo.time)"
        status.text = "Status : \(OrderInfo.status)"
        payment.text = "Payment : \(OrderInfo.payment)"
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(OrderDetailViewContainer)
        
        OrderDetailViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        OrderDetailViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        OrderDetailViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        OrderDetailViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        OrderDetailViewContainer.addArrangedSubview(storeViewContainer)
        storeViewContainer.addArrangedSubview(storeNameViewContainer)
        
        storeNameViewContainer.addArrangedSubview(storeNameLabel)
        storeNameViewContainer.addArrangedSubview(OrderEdit)
        
        
        storeViewContainer.addArrangedSubview(orderPlacedLabel)
       // storeViewContainer.addArrangedSubview(timeLabel)
        storeViewContainer.addArrangedSubview(status)
        storeViewContainer.addArrangedSubview(payment)
        
        
        OrderEdit.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        OrderEdit.setTitle("Edit", for: .normal)
        
       
       
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class newOrderCell: UITableViewCell {
    // MARK:- Variable Declaration
    let newOrderDetailViewContainer: UIStackView = {
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
        view.spacing = 8
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
    let newOrderPlacedLabel:UILabel = {
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
    
    static let identifier = String(describing: newOrderCell.self)
    
    // MARK:- Common Methods
    func configureData(newOrderInfo: newOrderModel) {
        storeNameLabel.text = "\(newOrderInfo.tableName) : \t sits \t  \(newOrderInfo.numberofpeoples)"
        newOrderPlacedLabel.text = "newOrder Placed : \(newOrderInfo.newOrderPlaced)"
        timeLabel.text = "Time Lapsed : \(newOrderInfo.time)"
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(newOrderDetailViewContainer)
        
        newOrderDetailViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        newOrderDetailViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        newOrderDetailViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        newOrderDetailViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        newOrderDetailViewContainer.addArrangedSubview(storeViewContainer)
        storeViewContainer.addArrangedSubview(storeNameViewContainer)
        
        storeNameViewContainer.addArrangedSubview(storeNameLabel)
        
        storeViewContainer.addArrangedSubview(newOrderPlacedLabel)
        storeViewContainer.addArrangedSubview(timeLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class menuOrderCell: UITableViewCell {
    // MARK:- Variable Declaration
    let newOrderDetailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let itemNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    let price:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    static let identifier = String(describing: menuOrderCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(newOrderDetailViewContainer)
        
        newOrderDetailViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        newOrderDetailViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        newOrderDetailViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        newOrderDetailViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        newOrderDetailViewContainer.addArrangedSubview(itemNameLabel)
        
        newOrderDetailViewContainer.addArrangedSubview(price)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class CheckableTableViewCell: UITableViewCell {
    let productViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let incdecViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let incDecViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let NameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    let incdec:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let btnDec:UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let incDecLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    let btnInc:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    static let identifier = String(describing: menuOrderCell.self)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(productViewContainer)
        productViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        productViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        productViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        productViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        productViewContainer.addArrangedSubview(NameLabel)
        productViewContainer.addArrangedSubview(incdecViewContainer)
        
        incdecViewContainer.addArrangedSubview(incdec)
        incdecViewContainer.addArrangedSubview(incDecViewContainer)
        incDecViewContainer.addArrangedSubview(btnDec)
        incDecViewContainer.addArrangedSubview(incDecLabel)
        incDecViewContainer.addArrangedSubview(btnInc)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.accessoryType = selected ? .checkmark : .none
    }
}
class OrderTableViewCell: UITableViewCell {
    let productViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let NameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    static let identifier = String(describing: menuOrderCell.self)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(productViewContainer)
        productViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        productViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        productViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        productViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        productViewContainer.addArrangedSubview(NameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // self.accessoryType = selected ? .checkmark : .none
    }
}
class OrderViewCell: UITableViewCell {
    let productViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let NameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    static let identifier = String(describing: menuOrderCell.self)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(productViewContainer)
        productViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        productViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        productViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        productViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        productViewContainer.addArrangedSubview(NameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // self.accessoryType = selected ? .checkmark : .none
    }
}
class CheckOutOrderViewCell: UITableViewCell {
    let productViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let NameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let productViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let qtyLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "2"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "24"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    static let identifier = String(describing: menuOrderCell.self)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(productViewContainer)
        productViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        productViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        productViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        productViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        productViewContainer.addArrangedSubview(NameLabel)
        productViewContainer.addArrangedSubview(productViewContainer1)
        productViewContainer1.addArrangedSubview(qtyLabel)
        productViewContainer1.addArrangedSubview(priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // self.accessoryType = selected ? .checkmark : .none
    }
}
