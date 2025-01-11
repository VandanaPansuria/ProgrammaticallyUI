//
//  PickUpVC.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import UIKit

class PickUpVC: UIViewController {

    
    var bookingInfo = BookingModel.empty
    lazy var itemsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var arrItems: [itemsModel] = [
        itemsModel(quantity: "2x", name: "samosa", price: "190")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "PickUp Order"
        self.view.backgroundColor = .white
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        
        //image
        self.view.addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.aspectRation(1.0/1.0).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.view.addSubview(storeViewContainer)
        storeViewContainer.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        
        storeViewContainer.leadingAnchor.constraint(equalTo:self.view.leadingAnchor).isActive = true
        storeViewContainer.trailingAnchor.constraint(equalTo:self.view.trailingAnchor).isActive = true
        
        storeViewContainer.addArrangedSubview(orderViewContainer)
        storeViewContainer.addArrangedSubview(timeViewContainer)
        storeViewContainer.addArrangedSubview(statusViewContainer)
        storeViewContainer.addArrangedSubview(idViewContainer)
        
        orderViewContainer.addArrangedSubview(orderLabel)
        orderViewContainer.addArrangedSubview(ordervalueLabel)
        timeViewContainer.addArrangedSubview(timeLabel)
        timeViewContainer.addArrangedSubview(timevalueLabel)
        statusViewContainer.addArrangedSubview(statusLabel)
        statusViewContainer.addArrangedSubview(statusvalueLabel)
        idViewContainer.addArrangedSubview(idLabel)
        idViewContainer.addArrangedSubview(idvalueLabel)
        
        self.view.addSubview(orderSummeryLabel)
        orderSummeryLabel.topAnchor.constraint(equalTo: storeViewContainer.bottomAnchor, constant: 10).isActive = true
        
        orderSummeryLabel.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 10).isActive = true
        orderSummeryLabel.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 10).isActive = true
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
        let footerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 120))
        self.itemsTableView.tableFooterView = footerView
        footerView.addSubview(totalViewContainer)
        
        totalViewContainer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor , constant: 12).isActive = true
        totalViewContainer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12).isActive = true
        totalViewContainer.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 12).isActive = true
        totalViewContainer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -12).isActive = true
        
        totalViewContainer.addArrangedSubview(basketvalueLabel)
        totalViewContainer.addArrangedSubview(taxvalueLabel)
        totalViewContainer.addArrangedSubview(totalpaidvalueLabel)
        
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
        let size1 = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size1.height {
            headerView.frame.size.height = size1.height
            self.itemsTableView.tableHeaderView = headerView
        }
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Variable Declaration
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
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .lightGray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let storeViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let orderViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let timeViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let statusViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let idViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let orderLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Order Placed : "
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ordervalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "27/11/2021"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Time : "
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timevalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "11:48:20"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let statusLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Status : "
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let statusvalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Submitted"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let idLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "ID : "
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let idvalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "634"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderSummeryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Order Summary"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let basketvalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Basket Total : 190 QR"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let taxvalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Tax : 5.0 QR"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalpaidvalueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Total Paid : 6.0 QR"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
// MARK:- UITableView Methods

extension PickUpVC: UITableViewDataSource, UITableViewDelegate {
    
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
    }
}
