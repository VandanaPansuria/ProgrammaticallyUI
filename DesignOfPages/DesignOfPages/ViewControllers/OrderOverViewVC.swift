//
//  OrderOverViewVC.swift
//  DesignOfPages
//
//  Created by MacV on 22/12/21.
//

import UIKit

class OrderOverViewVC: UIViewController {
    
    let OrderOverViewTable = UITableView()
    var lbl = UILabel()
    var customSC = UISegmentedControl()
    var subCustomSC = UISegmentedControl()
    private var arrOrderOverView: [OrderOverView] = [
        OrderOverView(menuName: "Samosa", menuValue: ["Small","Cheese","No Lettuce","No Tamato"],qtyValue : "2"),
        OrderOverView(menuName: "Beef", menuValue: ["Medium","Ketchup","Cheese extra","No Mayo"],qtyValue : "3"),
        OrderOverView(menuName: "Lamb", menuValue: ["Medium well","Ketchup","Cheese", "No Mayo"],qtyValue : "4"),
        OrderOverView(menuName: "Curry", menuValue: ["Medium Hot","No Tamato","No Spice"],qtyValue : "5")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Order OverView"
        self.view.backgroundColor = .white
        
        
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        //TableView
        view.addSubview(OrderOverViewTable)
        
        OrderOverViewTable.translatesAutoresizingMaskIntoConstraints = false
        OrderOverViewTable.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        OrderOverViewTable.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        OrderOverViewTable.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        OrderOverViewTable.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        OrderOverViewTable.dataSource = self
        OrderOverViewTable.delegate = self
        OrderOverViewTable.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        self.OrderOverViewTable.allowsMultipleSelection = true
        self.OrderOverViewTable.allowsMultipleSelectionDuringEditing = true
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 10, width: UIScreen.main.bounds.width, height: 30))
        self.OrderOverViewTable.tableHeaderView = headerView
        headerView.addSubview(orderViewContainer)
        
        orderViewContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor , constant: 12).isActive = true
        orderViewContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12).isActive = true
        orderViewContainer.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        orderViewContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        
        orderViewContainer.addArrangedSubview(itemsLabel)
        orderViewContainer.addArrangedSubview(orderValueViewContainer)
        orderValueViewContainer.addArrangedSubview(qtyLabel)
        orderValueViewContainer.addArrangedSubview(priceLabel)
        orderValueViewContainer.addArrangedSubview(deleteLabel)
        
        //Footer
        let footerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 140))
        self.OrderOverViewTable.tableFooterView = footerView
        footerView.addSubview(footerViewContainer)
        
        footerViewContainer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor , constant: 12).isActive = true
        footerViewContainer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12).isActive = true
        footerViewContainer.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 12).isActive = true
        footerViewContainer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -12).isActive = true
        footerViewContainer.addArrangedSubview(totalViewContainer)
        totalViewContainer.addArrangedSubview(totalNumberLabel)
        totalViewContainer.addArrangedSubview(tableNumberLabel)
        footerViewContainer.addArrangedSubview(footerTotalViewContainer)
        footerTotalViewContainer.addArrangedSubview(UIView())
        footerTotalViewContainer.addArrangedSubview(footerTotalViewContainer1)
        footerTotalViewContainer1.addArrangedSubview(subtotalLabel)
        footerTotalViewContainer1.addArrangedSubview(totalValueLabel)
        footerViewContainer.addArrangedSubview(footerTaxViewContainer)
        footerTaxViewContainer.addArrangedSubview(UIView())
        footerTaxViewContainer.addArrangedSubview(footerTaxViewContainer1)
        footerTaxViewContainer1.addArrangedSubview(taxLabel)
        footerTaxViewContainer1.addArrangedSubview(taxValueLabel)
        footerViewContainer.addArrangedSubview(footerSubViewContainer)
        footerSubViewContainer.addArrangedSubview(UIView())
        footerSubViewContainer.addArrangedSubview(footerSubViewContainer1)
        footerSubViewContainer1.addArrangedSubview(subLabel)
        footerSubViewContainer1.addArrangedSubview(subValueLabel)
        
        footerViewContainer.addArrangedSubview(orderBtn)
        orderBtn.addTarget(self, action: #selector(makeOrderAction(_:)), for: .touchUpInside)
        
        //        for _ in 1...arrOrderOverView.count{
        //            arrQtyValue.append("2")
        //        }
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //Variable
    let orderViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let itemsLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Items"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderValueViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let qtyLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Qty"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Price"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let deleteLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Delete"
        label.textAlignment = .center
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
    let totalViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let totalNumberLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Total Number of items"
        //label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableNumberLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "16"
        // label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let footerTotalViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let footerTotalViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let subtotalLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Total"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "34"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let footerTaxViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let footerTaxViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let taxLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Tax"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let taxValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "34"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let footerSubViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let footerSubViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let subLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Sub"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "34"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("MAKE ORDER", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.195286423, green: 0.4249245524, blue: 0.5362681746, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let footerView = self.OrderOverViewTable.tableFooterView else {
            return
        }
        let width = self.OrderOverViewTable.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.OrderOverViewTable.tableFooterView = footerView
        }
        guard let headerView = self.OrderOverViewTable.tableHeaderView else {
            return
        }
        let size1 = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size1.height {
            headerView.frame.size.height = size1.height
            self.OrderOverViewTable.tableHeaderView = headerView
        }
    }
}
// MARK:- UITableView Methods

extension OrderOverViewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrderOverView[section].menuValue?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        cell.NameLabel.text = arrOrderOverView[indexPath.section].menuValue?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrOrderOverView.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90))
        view.backgroundColor =  .white
        let lblname = UILabel(frame: CGRect(x: 5, y: 0, width: view.frame.width / 2, height: 30))
        lblname.font = UIFont.boldSystemFont(ofSize: 20)
        lblname.text = arrOrderOverView[section].menuName
        view.addSubview(lblname)
        
        let viewQty = UIView(frame: CGRect(x: view.frame.width / 2, y: 0, width: (view.frame.width / 2) / 3, height: 30))
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 0
        stackview.distribution = .fillProportionally
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        let minusbtn = UIButton()
        minusbtn.tintColor = .black
        minusbtn.setImage(UIImage(systemName: "minus"), for: .normal)
        minusbtn.tag = section
        minusbtn.addTarget(self, action: #selector(didTapMinusButton(sender:)), for: .touchUpInside)
        
        let lblQty = UILabel()
        lblQty.font = UIFont.boldSystemFont(ofSize: 16)
        lblQty.textAlignment = .center
        lblQty.text = arrOrderOverView[section].qtyValue
        
        let plusbtn = UIButton()
        plusbtn.setImage(UIImage(systemName: "plus"), for: .normal)
        plusbtn.tintColor = .black
        plusbtn.tag = section
        plusbtn.addTarget(self, action: #selector(didTapPlusButton(sender:)), for: .touchUpInside)
        
        viewQty.addSubview(stackview)
        stackview.topAnchor.constraint(equalTo: viewQty.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: viewQty.bottomAnchor).isActive = true
        stackview.heightAnchor.constraint(equalTo: viewQty.heightAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: viewQty.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: viewQty.trailingAnchor).isActive = true
        view.addSubview(viewQty)
        stackview.addArrangedSubview(minusbtn)
        stackview.addArrangedSubview(lblQty)
        stackview.addArrangedSubview(plusbtn)
        
        let lblPrice = UILabel(frame: CGRect(x: viewQty.frame.origin.x + viewQty.frame.size.width, y: 0, width: (view.frame.width / 2) / 3, height: 30))
        lblPrice.font = UIFont.boldSystemFont(ofSize: 20)
        lblPrice.textAlignment = .center
        lblPrice.text = "43"
        view.addSubview(lblPrice)
        
        let imgTrash = UIButton(frame: CGRect(x: lblPrice.frame.origin.x + lblPrice.frame.size.width, y: 0, width: (view.frame.width / 2) / 3, height: 25))
        imgTrash.contentMode = .scaleAspectFit
        imgTrash.tintColor = .black
        imgTrash.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        imgTrash.tag = section
        imgTrash.tintColor = .red
        imgTrash.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
        view.addSubview(imgTrash)
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    @objc func deleteAction(_ sender: UIButton) {
        arrOrderOverView.remove(at: sender.tag)
        self.OrderOverViewTable.reloadData()
    }
    @objc func makeOrderAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func didTapPlusButton(sender: UIButton) {
        arrOrderOverView[sender.tag].qtyValue = String(Int(arrOrderOverView[sender.tag].qtyValue ?? "")! + 1)
        OrderOverViewTable.reloadSections([sender.tag], with: .none)
    }
    @objc func didTapMinusButton(sender: UIButton) {
//        let indexPath = IndexPath(row: sender.tag, section: sender.tag)
//        let csh = OrderOverViewTable.headerView(forSection: indexPath.section)
//        csh?.textLabel?.text = "3"
        if Int(arrOrderOverView[sender.tag].qtyValue ?? "")! != -1{
            arrOrderOverView[sender.tag].qtyValue = String(Int(arrOrderOverView[sender.tag].qtyValue ?? "")! - 1)
            OrderOverViewTable.reloadSections([sender.tag], with: .none)
        }
        if Int(arrOrderOverView[sender.tag].qtyValue ?? "")! == 0{
            arrOrderOverView.remove(at: sender.tag)
            self.OrderOverViewTable.reloadData()
        }
    }
}
