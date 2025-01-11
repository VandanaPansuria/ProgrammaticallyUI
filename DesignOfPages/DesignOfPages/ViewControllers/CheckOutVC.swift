//
//  CheckOutVC.swift
//  DesignOfPages
//
//  Created by MacV on 24/12/21.
//

import UIKit

class CheckOutVC: UIViewController, UITextFieldDelegate {
    
    let CheckOutOrderViewTable = UITableView()
    var txtField = UITextField()
    var lbl = UILabel()
    var payOrNot = ""
    //var customSC = UISegmentedControl()
    var subCustomSC = UISegmentedControl()
    private var arrCheckOutOrderView: [CheckOutOrderView] = [
        CheckOutOrderView(menuName: "Lamb ",qty: "2",price: "40"),
        CheckOutOrderView(menuName: "Beef",qty: "4",price: "140"),
        CheckOutOrderView(menuName: "chicken",qty: "2",price: "180")
    ]
    var totalCountOfTable : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CheckOut"
        self.view.backgroundColor = .white
        txtAmount.delegate = self
        txtChange.delegate = self
        txtEmail.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        //TableView
        view.addSubview(CheckOutOrderViewTable)
        
        CheckOutOrderViewTable.translatesAutoresizingMaskIntoConstraints = false
        CheckOutOrderViewTable.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckOutOrderViewTable.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        CheckOutOrderViewTable.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        CheckOutOrderViewTable.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        CheckOutOrderViewTable.dataSource = self
        CheckOutOrderViewTable.delegate = self
        CheckOutOrderViewTable.register(CheckOutOrderViewCell.self, forCellReuseIdentifier: "CheckOutOrderViewCell")
        self.CheckOutOrderViewTable.allowsMultipleSelection = true
        self.CheckOutOrderViewTable.allowsMultipleSelectionDuringEditing = true
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 10, width: UIScreen.main.bounds.width, height: 30))
        self.CheckOutOrderViewTable.tableHeaderView = headerView
        headerView.addSubview(CheckOutOrderViewContainer)
        
        CheckOutOrderViewContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor , constant: 12).isActive = true
        CheckOutOrderViewContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12).isActive = true
        CheckOutOrderViewContainer.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        CheckOutOrderViewContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        
        CheckOutOrderViewContainer.addArrangedSubview(itemsLabel)
        
        //Footer
        let footerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 140))
        self.CheckOutOrderViewTable.tableFooterView = footerView
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
        footerViewContainer.addArrangedSubview(footerDiscViewContainer)
        footerDiscViewContainer.addArrangedSubview(UIView())
        footerDiscViewContainer.addArrangedSubview(footerDiscViewContainer1)
        footerDiscViewContainer1.addArrangedSubview(DiscLabel)
        footerDiscViewContainer1.addArrangedSubview(DiscValueLabel)
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
        footerStatusContainer.addArrangedSubview(segment)
        segment.heightAnchor.constraint(equalToConstant: 50).isActive = true
        footerViewContainer.addArrangedSubview(billViewContainer)
        billViewContainer.addArrangedSubview(billLabel)
        footerViewContainer.addArrangedSubview(billViewContainer1)
        payNow()
        billViewContainer1.isHidden = true
    }
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    func payNow(){
        //if payOrNot == "pay"{
        billViewContainer1.addArrangedSubview(paymentLabel)
        billViewContainer1.addArrangedSubview(paymentTypeSegment)
        
        paymentTypeSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        billViewContainer1.addArrangedSubview(TenderViewContainer)
        TenderViewContainer.addArrangedSubview(amountLabel)
        TenderViewContainer.addArrangedSubview(txtAmount)
        TenderViewContainer.addArrangedSubview(changeLabel)
        TenderViewContainer.addArrangedSubview(txtChange)
        
        billViewContainer1.addArrangedSubview(keypadViewContainer)
        keypadViewContainer.addArrangedSubview(numberViewContainer)
        keypadViewContainer.addArrangedSubview(priceViewContainer)
        
        numberViewContainer.addArrangedSubview(number1ViewContainer)
        number1ViewContainer.addArrangedSubview(sevenBtn)
        sevenBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number1ViewContainer.addArrangedSubview(eitghBtn)
        eitghBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number1ViewContainer.addArrangedSubview(nineBtn)
        nineBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        
        numberViewContainer.addArrangedSubview(number2ViewContainer)
        number2ViewContainer.addArrangedSubview(fourBtn)
        fourBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number2ViewContainer.addArrangedSubview(fiveBtn)
        fiveBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number2ViewContainer.addArrangedSubview(sixBtn)
        sixBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        
        numberViewContainer.addArrangedSubview(number3ViewContainer)
        number3ViewContainer.addArrangedSubview(oneBtn)
        oneBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number3ViewContainer.addArrangedSubview(twoBtn)
        twoBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number3ViewContainer.addArrangedSubview(threeBtn)
        threeBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        
        numberViewContainer.addArrangedSubview(number4ViewContainer)
        number4ViewContainer.addArrangedSubview(dotBtn)
        dotBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number4ViewContainer.addArrangedSubview(zeroBtn)
        zeroBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number4ViewContainer.addArrangedSubview(backBtn)
        backBtn.addTarget(self, action: #selector(removeDigits(_:)), for: .touchUpInside)
        
        numberViewContainer.addArrangedSubview(number5ViewContainer)
        number5ViewContainer.addArrangedSubview(yellowOneBtn)
        yellowOneBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number5ViewContainer.addArrangedSubview(yellowFiveBtn)
        yellowFiveBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        number5ViewContainer.addArrangedSubview(yellowTenBtn)
        yellowTenBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        priceViewContainer.addArrangedSubview(totalBtn)
        totalBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        priceViewContainer.addArrangedSubview(hundredBtn)
        hundredBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        priceViewContainer.addArrangedSubview(fiftyBtn)
        fiftyBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        priceViewContainer.addArrangedSubview(twentyBtn)
        twentyBtn.addTarget(self, action: #selector(keyPadTapaction(_:)), for: .touchUpInside)
        
        billViewContainer1.addArrangedSubview(emailViewContainer)
        emailViewContainer.addArrangedSubview(emailLabel)
        emailViewContainer.addArrangedSubview(txtEmail)
        billViewContainer1.addArrangedSubview(saveBtn)
        // }
        for element in arrCheckOutOrderView{
            totalCountOfTable = totalCountOfTable + Int(element.price!)!
        }
        totalValueLabel.text = "\(totalCountOfTable)"
        
        let value = self.calculatePercentage(value: Double(self.totalValueLabel.text!) ?? 0,percentageVal: 20)
        self.DiscValueLabel.text = "\(20)%(\(value))"
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        txtField = textField
        dismissKeyboard()
        return true
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtAmount || textField == txtChange {
            dismissKeyboard()
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return true
            } else {
                if let char = string.cString(using: String.Encoding.utf8) {
                    let isBackSpace = strcmp(char, "\\b")
                    if (isBackSpace == -92) {
                        return true
                    }else{
                        return false
                    }
                } else{
                    return false
                }
            }
            
        }else if textField == txtEmail{
            return true
        }else{
            return false
        }
    }
    @objc func changeSegmentValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            payHideShow(flag: true)
            alertWithTextField(title: "Split", message: "How much?", placeholder: "Splite") { result in
                print(result)
            }
        case 1:
            payHideShow(flag: true)
            alertWithTextField(title: "Order", message: "How much?", placeholder: "Delete Order") { result in
                print(result)
            }
        case 2:
            payHideShow(flag: true)
            alertWithTextField(title: "Discount", message: "How much?", placeholder: "Discount") { resultText in
                var result = resultText
                if result.localizedCaseInsensitiveContains("%"){
                    result = result.replacingOccurrences(of: "%", with: "")
                }
                if result.isNumber{
                    let value = self.calculatePercentage(value: Double(self.totalValueLabel.text!) ?? 0,percentageVal: Double(result) ?? 0)
                    self.DiscValueLabel.text = "\(result)%(\(value))"
                }
            }
        case 3:
            payHideShow(flag: false)
            
        default:
            print(sender.selectedSegmentIndex)
        }
    }
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
    }
    func payHideShow(flag : Bool){
        billViewContainer1.isHidden = flag
        guard let footerView = self.CheckOutOrderViewTable.tableFooterView else {
            return
        }
        let width = self.CheckOutOrderViewTable.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.CheckOutOrderViewTable.tableFooterView = footerView
        }
    }
    public func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("") })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result) }
            else
            { completion("") }
        })
        navigationController?.present(alert, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func keyPadTapaction(_ sender: UIButton) {
        if txtField == txtAmount{
            if txtAmount.text?.count ?? 0 > 0{
                let senderTitle = sender.currentTitle
                txtAmount.text = txtAmount.text! + senderTitle!
            }else{
                txtAmount.text = sender.currentTitle
            }
        }else if txtField == txtChange{
            if txtChange.text?.count ?? 0 > 0{
                let senderTitle = sender.currentTitle
                txtChange.text = txtChange.text! + senderTitle!
            }else{
                txtChange.text = sender.currentTitle
            }
        }
    }
    @objc func removeDigits(_ sender: UIButton){
        if txtField == txtAmount{
            txtAmount.becomeFirstResponder()
            txtAmount.text = String(txtAmount.text?.dropLast() ?? "")
        }else if txtField == txtChange{
            txtChange.becomeFirstResponder()
            txtChange.text = String(txtChange.text?.dropLast() ?? "")
        }
    }
    //Variable
    let billViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let billViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var segment:UISegmentedControl = {
        //"Print Receipt"
        let items = ["Split", "Delete Order", "Discount","Pay Now"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 2.0
        customSC.backgroundColor = .lightGray
        customSC.tintColor = UIColor.white
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        customSC.translatesAutoresizingMaskIntoConstraints = true
        customSC.addTarget(self, action: #selector(changeSegmentValue(sender:)), for: .valueChanged)
        return customSC
    }()
    var paymentTypeSegment:UISegmentedControl = {
        let items = ["CASH", "VISA", "Master Card","American"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 2.0
        customSC.backgroundColor = .lightGray
        customSC.tintColor = UIColor.white
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        customSC.translatesAutoresizingMaskIntoConstraints = true
        return customSC
    }()
    let CheckOutOrderViewContainer: UIStackView = {
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
        label.text = "Tabel 3"
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
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "34"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let footerDiscViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let footerDiscViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let DiscLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Discount"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let DiscValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "20%(16)"
        label.textAlignment = .right
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
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let taxValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "34"
        label.textAlignment = .right
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
        label.text = "Sub Total"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "34"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let footerStatusContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let billLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Bill is 213"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let paymentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Payment Type"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let TenderViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let amountLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Tender Amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var txtAmount:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor =  .black
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.textAlignment = .center
        txt.heightAnchor.constraint(equalToConstant: 35).isActive = true
        txt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    let changeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Change"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let txtChange:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor =  .black
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.textAlignment = .center
        txt.heightAnchor.constraint(equalToConstant: 35).isActive = true
        txt.widthAnchor.constraint(equalToConstant: 50).isActive = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    let environmentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Save The Environment"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let keypadViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.backgroundColor = #colorLiteral(red: 0.9685322642, green: 0.9686941504, blue: 0.9685109258, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let numberViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let number1ViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sevenBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("7", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let eitghBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("8", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let nineBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("9", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let number2ViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let fourBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("4", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let fiveBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("5", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let sixBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("6", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let number3ViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let oneBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("1", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let twoBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("2", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let threeBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("3", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let number4ViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let dotBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle(".", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let zeroBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("0", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let backBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        btn.backgroundColor = .white
        btn.tintColor = .red
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let number5ViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let yellowOneBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(236.0/255.0), green: (185.0/255.0), blue: (87.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("1", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let yellowFiveBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(236.0/255.0), green: (185.0/255.0), blue: (87.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("5", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let yellowTenBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(236.0/255.0), green: (185.0/255.0), blue: (87.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("10", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let priceViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        view.distribution = .fillProportionally
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let totalBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(101.0/255.0), green: (196.0/255.0), blue: (90.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("10.00", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 102).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let hundredBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(236.0/255.0), green: (185.0/255.0), blue: (87.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("100", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let fiftyBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(236.0/255.0), green: (185.0/255.0), blue: (87.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("50", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let twentyBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(red:(236.0/255.0), green: (185.0/255.0), blue: (87.0/255.0), alpha: 1.0), for: .normal)
        btn.setTitle("20", for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let emailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Email Address"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let txtEmail:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor =  .black
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.keyboardType = .emailAddress
        txt.heightAnchor.constraint(equalToConstant: 35).isActive = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    let saveBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("SAVE", for: .normal)
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
        guard let footerView = self.CheckOutOrderViewTable.tableFooterView else {
            return
        }
        let width = self.CheckOutOrderViewTable.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.CheckOutOrderViewTable.tableFooterView = footerView
        }
        guard let headerView = self.CheckOutOrderViewTable.tableHeaderView else {
            return
        }
        let size1 = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size1.height {
            headerView.frame.size.height = size1.height
            self.CheckOutOrderViewTable.tableHeaderView = headerView
        }
        let rect = CGRect(origin: segment.frame.origin, size: CGSize(width: segment.frame.size.width, height: 100))
        segment.frame = rect
    }
}
// MARK:- UITableView Methods

extension CheckOutVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCheckOutOrderView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutOrderViewCell", for: indexPath) as! CheckOutOrderViewCell
        cell.NameLabel.text = arrCheckOutOrderView[indexPath.row].menuName
        cell.qtyLabel.text = arrCheckOutOrderView[indexPath.row].qty
        cell.priceLabel.text = arrCheckOutOrderView[indexPath.row].price
        return cell
    }
    @objc func deleteAction(_ sender: UIButton) {
        arrCheckOutOrderView.remove(at: sender.tag)
        self.CheckOutOrderViewTable.reloadData()
    }
    @objc func preparAction(_ sender: UIButton) {
        print("Prepare")
    }
    @objc func didTapPayButton(sender: UIButton) {
        let vc = CheckOutVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
