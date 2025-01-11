//
//  StoreNameVC.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import UIKit

class StoreNameVC: UIViewController {

    var bookingInfo = BookingModel.empty
    lazy var itemsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var arrItems: [itemsModel] = [
        itemsModel(quantity: "4", name: "samosa", price: "120")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order Details"
        self.view.backgroundColor = .white
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        //container
        self.view.addSubview(bookingDetailViewContainer)
        
        bookingDetailViewContainer.translatesAutoresizingMaskIntoConstraints = false
        bookingDetailViewContainer.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        bookingDetailViewContainer.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bookingDetailViewContainer.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
      //  bookingDetailViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        bookingDetailViewContainer.addArrangedSubview(iconImageView)
        bookingDetailViewContainer.addArrangedSubview(storeViewContainer)
        storeViewContainer.addArrangedSubview(storeNameLabel)
        storeViewContainer.addArrangedSubview(timeLabel)
        storeViewContainer.addArrangedSubview(orderNumberLabel)
        
        iconImageView.backgroundColor = .lightGray
        iconImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        iconImageView.topAnchor.constraint(equalTo: bookingDetailViewContainer.topAnchor, constant: 10).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: bookingDetailViewContainer.bottomAnchor, constant: -10).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: bookingDetailViewContainer.leadingAnchor, constant: 10).isActive = true
        //order summery
        self.view.addSubview(orderSummeryLabel)
        orderSummeryLabel.topAnchor.constraint(equalTo: bookingDetailViewContainer.bottomAnchor, constant: 20).isActive = true
        orderSummeryLabel.leadingAnchor.constraint(equalTo: bookingDetailViewContainer.leadingAnchor, constant: 10).isActive = true
        orderSummeryLabel.trailingAnchor.constraint(equalTo: bookingDetailViewContainer.trailingAnchor, constant: -10).isActive = true
       
        configureData(bookingInfo: self.bookingInfo)
        
        //TableView
       
        view.addSubview(itemsTableView)
       
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.topAnchor.constraint(equalTo:orderSummeryLabel.bottomAnchor, constant: 10).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.register(ItemsCell.self, forCellReuseIdentifier: "ItemsCell")
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 50))
        self.itemsTableView.tableHeaderView = headerView
        headerView.addSubview(headerViewContainer)
       
        headerViewContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor , constant: 12).isActive = true
        headerViewContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12).isActive = true
        headerViewContainer.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        headerViewContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        
        headerViewContainer.addArrangedSubview(headerDetailViewContainer)
        headerViewContainer.addArrangedSubview(underlineView)
        headerDetailViewContainer.addArrangedSubview(quantityLabel)
        headerDetailViewContainer.addArrangedSubview(itemNameLabel)
        headerDetailViewContainer.addArrangedSubview(priceLabel)
        
        //Footer
        let footerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 140))
        self.itemsTableView.tableFooterView = footerView
        footerView.addSubview(footerViewContainer)
        
        footerViewContainer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor , constant: 12).isActive = true
        footerViewContainer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12).isActive = true
        footerViewContainer.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 12).isActive = true
        footerViewContainer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -12).isActive = true
        
        footerViewContainer.addArrangedSubview(subtotalLabel)
        footerViewContainer.addArrangedSubview(taxLabel)
        footerViewContainer.addArrangedSubview(totalPaidLabel)
        footerViewContainer.addArrangedSubview(paymentLabel)
        footerViewContainer.addArrangedSubview(specialLabel)
        footerViewContainer.addArrangedSubview(nameLabel)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let footerView = self.itemsTableView.tableFooterView else {
            return
            
        }
        let width = self.itemsTableView.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.itemsTableView.tableFooterView = footerView
        }
        
        guard let headerView = self.itemsTableView.tableHeaderView else {
            return
            
        }
        //let width = self.itemsTableView.bounds.size.width
        let size1 = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size1.height {
            headerView.frame.size.height = size1.height
            self.itemsTableView.tableHeaderView = headerView
        }
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func configureData(bookingInfo: BookingModel) {
        iconImageView.image = UIImage(named: "")
        timeLabel.text = "Time : \(bookingInfo.time)"
        orderNumberLabel.text = "Order Number : 91"
        storeNameLabel.text = bookingInfo.storeName
    }
    // MARK:- Variable Declaration
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
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
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let storeNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderNumberLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderSummeryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Order Summary"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let headerViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let headerDetailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let quantityLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Quantity"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let itemNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Product Name"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Price"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let specialLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Special Request"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "No special instruction"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let footerViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let subtotalLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "SubTotal : 34"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let taxLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Tax QR 5.0"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPaidLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Total QR 204.98"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let paymentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Payment Method : Cash"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
// MARK:- UITableView Methods

extension StoreNameVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard arrItems.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: ItemsCell.identifier, for: indexPath) as? ItemsCell else {
                  return UITableViewCell()
              }
        let itemsInfo = arrItems[indexPath.row]
        cell.configureData(itemInfo: itemsInfo)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PickUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
