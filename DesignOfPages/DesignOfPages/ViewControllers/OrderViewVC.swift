//
//  OrderViewVC.swift
//  DesignOfPages
//
//  Created by MacV on 22/12/21.
//

import UIKit

class OrderViewVC: UIViewController {
    
    let OrderViewTable = UITableView()
    
    var lbl = UILabel()
    var customSC = UISegmentedControl()
    var subCustomSC = UISegmentedControl()
    let dataArray = ["Start","Preparing", "Completed"]
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    private var arrOrderView: [OrderView] = [
        OrderView(menuName: "Lamb Chop", menuValue: ["No Ketchup","Mayo","Vendor"], qtyValue: "3"),
        OrderView(menuName: "Lamb Burger", menuValue: ["Extra cheese","Extra Beef","Extra Mayo"], qtyValue: "5")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Order View"
        self.view.backgroundColor = .white
        
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        //TableView
        view.addSubview(OrderViewTable)
        
        OrderViewTable.translatesAutoresizingMaskIntoConstraints = false
        OrderViewTable.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        OrderViewTable.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        OrderViewTable.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        OrderViewTable.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        OrderViewTable.dataSource = self
        OrderViewTable.delegate = self
        OrderViewTable.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        self.OrderViewTable.allowsMultipleSelection = true
        self.OrderViewTable.allowsMultipleSelectionDuringEditing = true
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 10, width: UIScreen.main.bounds.width, height: 30))
        self.OrderViewTable.tableHeaderView = headerView
        headerView.addSubview(orderViewContainer)
       
        orderViewContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor , constant: 12).isActive = true
        orderViewContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12).isActive = true
        orderViewContainer.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        orderViewContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        
        orderViewContainer.addArrangedSubview(itemsLabel)
        orderViewContainer.addArrangedSubview(orderValueViewContainer)
        orderValueViewContainer.addArrangedSubview(qtyLabel)
        orderValueViewContainer.addArrangedSubview(priceLabel)
        
        //Footer
        let footerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 140))
        self.OrderViewTable.tableFooterView = footerView
        footerView.addSubview(footerViewContainer)
        
        footerViewContainer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor , constant: 12).isActive = true
        footerViewContainer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12).isActive = true
        footerViewContainer.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 12).isActive = true
        footerViewContainer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -12).isActive = true
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
        footerViewContainer.addArrangedSubview(footerStatusContainer)
        footerStatusContainer.addArrangedSubview(statusLabel)
        footerStatusContainer.addArrangedSubview(preparingBtn)
        footerViewContainer.addArrangedSubview(completedBtn)
        footerViewContainer.addArrangedSubview(payBtn)
        footerViewContainer.addArrangedSubview(paidFullBtn)
        
        if (preparingBtn.titleLabel?.text == "Completed"){
            completedBtn.isHidden = true
            payBtn.isHidden = true
            paidFullBtn.isHidden = false
        }else{
            completedBtn.isHidden = true
            payBtn.isHidden = false
            paidFullBtn.isHidden = true
        }
        
        payBtn.addTarget(self, action: #selector(didTapPayButton(sender:)), for: .touchUpInside)
        completedBtn.addTarget(self, action: #selector(didTapCompletedButton(sender:)), for: .touchUpInside)
        
        preparingBtn.addTarget(self, action: #selector(troubleAction(_:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePickerView))
        OrderViewTable.addGestureRecognizer(tap)
       
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func troubleAction(_ sender: UIButton) {
        if sender.isSelected{
            onDoneButtonTapped()
            sender.isSelected = false
        }else{
            picker = UIPickerView.init()
            picker.delegate = self
            picker.dataSource = self
            picker.backgroundColor = UIColor.white
            picker.setValue(UIColor.black, forKey: "textColor")
            picker.autoresizingMask = .flexibleWidth
            picker.contentMode = .center
            picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(picker)
                    
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.barStyle = .blackTranslucent
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
                sender.isSelected = true
        }
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
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
        label.font = UIFont.boldSystemFont(ofSize: 17)
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
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Qty"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Pay"
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
    let footerStatusContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let statusLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Staus : "
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let preparingBtn:LayoutableButton = {
        let btn = LayoutableButton()
        btn.imageVerticalAlignment = .center
        btn.imageHorizontalAlignment = .right
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Preparing", for: .normal)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
       // btn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let completedBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Completed", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.195286423, green: 0.4249245524, blue: 0.5362681746, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    let payBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("PAY", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.heightAnchor.constraint(equalToConstant:40).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.195286423, green: 0.4249245524, blue: 0.5362681746, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    let paidFullBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("PAID FULL 8:30", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btn.backgroundColor = UIColor.green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let footerView = self.OrderViewTable.tableFooterView else {
            return
        }
        let width = self.OrderViewTable.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.OrderViewTable.tableFooterView = footerView
        }
        guard let headerView = self.OrderViewTable.tableHeaderView else {
            return
        }
        let size1 = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size1.height {
            headerView.frame.size.height = size1.height
            self.OrderViewTable.tableHeaderView = headerView
        }
    }
}
// MARK:- UITableView Methods

extension OrderViewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrderView[section].menuValue?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.NameLabel.text = arrOrderView[indexPath.section].menuValue?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrOrderView.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90))
        view.backgroundColor =  .white
        let lblname = UILabel(frame: CGRect(x: 5, y: 0, width: view.frame.width / 2, height: 30))
        lblname.font = UIFont.boldSystemFont(ofSize: 17)
        lblname.text = arrOrderView[section].menuName
        view.addSubview(lblname)
     
        let viewQty = UIView(frame: CGRect(x: view.frame.width / 2, y: 0, width: (view.frame.width / 2) / 2, height: 30))
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 2
        stackview.distribution = .fillProportionally
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        let minusbtn = UIButton()
        minusbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        minusbtn.setTitleColor(.black, for: .normal)
        minusbtn.tag = section
        minusbtn.setTitle("-", for: .normal)
        minusbtn.addTarget(self, action: #selector(didTapMinusButton(sender:)), for: .touchUpInside)
        
        let lblQty = UILabel()
        lblQty.font = UIFont.boldSystemFont(ofSize: 17)
        lblQty.textAlignment = .center
        lblQty.tag = section
        lblQty.text =  arrOrderView[section].qtyValue
        
        let plusbtn = UIButton()
        plusbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        plusbtn.setTitleColor(.black, for: .normal)
        plusbtn.setTitle("+", for: .normal)
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
        
        let lblPrice = UILabel(frame: CGRect(x: viewQty.frame.origin.x + viewQty.frame.size.width, y: 0, width: (view.frame.width / 2) / 2, height: 30))
        lblPrice.font = UIFont.boldSystemFont(ofSize: 17)
        lblPrice.textAlignment = .center
        lblPrice.text = "43QR"
        view.addSubview(lblPrice)
        
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    @objc func deleteAction(_ sender: UIButton) {
        arrOrderView.remove(at: sender.tag)
        self.OrderViewTable.reloadData()
    }
    @objc func didTapPayButton(sender: UIButton) {
        let vc = CheckOutVC()
        vc.payOrNot = "pay"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapCompletedButton(sender: UIButton) {
        let vc = CheckOutVC()
        vc.payOrNot = "completed"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapPlusButton(sender: UIButton) {
        arrOrderView[sender.tag].qtyValue = String(Int(arrOrderView[sender.tag].qtyValue ?? "")! + 1)
        OrderViewTable.reloadSections([sender.tag], with: .none)
    }
    @objc func didTapMinusButton(sender: UIButton) {
        if Int(arrOrderView[sender.tag].qtyValue ?? "")! != -1{
            arrOrderView[sender.tag].qtyValue = String(Int(arrOrderView[sender.tag].qtyValue ?? "")! - 1)
            OrderViewTable.reloadSections([sender.tag], with: .none)
        }
        if Int(arrOrderView[sender.tag].qtyValue ?? "")! == 0{
            arrOrderView.remove(at: sender.tag)
            self.OrderViewTable.reloadData()
        }
    }
}
extension OrderViewVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return dataArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = dataArray[row]
        return row
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        preparingBtn.setTitle(dataArray[row], for: .normal)
        if (preparingBtn.titleLabel?.text == "Completed"){
            completedBtn.isHidden = true
            payBtn.isHidden = true
            paidFullBtn.isHidden = false
        }else{
            completedBtn.isHidden = true
            payBtn.isHidden = false
            paidFullBtn.isHidden = true
        }
    }
    @objc func closePickerView()
    {
       onDoneButtonTapped()
    }
}
