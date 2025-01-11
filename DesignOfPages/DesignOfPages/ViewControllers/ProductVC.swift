//
//  ProductVC.swift
//  DesignOfPages
//
//  Created by MacV on 21/12/21.
//

import UIKit

class ProductVC: UIViewController {
    
    let productTableView = UITableView()
    var itemName = ""
    var lbl = UILabel()
    var customSC = UISegmentedControl()
    var subCustomSC = UISegmentedControl()
    private var arrProductOrder: [ProductOrder] = [
        ProductOrder(menuName: "Price and Size", menuValue: ["Small","Medium","Large"], increseDescrese: ["9.99","16.99","19.99"]),
        ProductOrder(menuName: "Ingredience", menuValue: ["Beef Patty","Lettuce","Tomatos","Onion"], increseDescrese: []),
        ProductOrder(menuName: "Cooking Points", menuValue: ["Medium well","Medium"], increseDescrese: []),
        ProductOrder(menuName: "Additional Items", menuValue: ["Cheese","Bacan","Eggs"], increseDescrese: ["0.5" , "1.0","2.0"],incDec: ["1.0","2.0","3.0"])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product View"
        self.view.backgroundColor = .white
        print(itemName)
        if itemName != "Pizza"{
            arrProductOrder.remove(at: 0)
        }
        
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        //TableView
        view.addSubview(productTableView)
        
        productTableView.translatesAutoresizingMaskIntoConstraints = false
        productTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        productTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        productTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        productTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(CheckableTableViewCell.self, forCellReuseIdentifier: "CheckableTableViewCell")
        self.productTableView.allowsMultipleSelection = true
        self.productTableView.allowsMultipleSelectionDuringEditing = true
        //navigation bar button
        let AddButton   = UIBarButtonItem(title: "ADD Item",  style: .plain, target: self, action: #selector(didTapAddButton))
        
        self.navigationItem.rightBarButtonItem = AddButton
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 200))
        self.productTableView.tableHeaderView = headerView
        headerView.addSubview(headerViewContainer)
        
        headerViewContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor , constant: 12).isActive = true
        headerViewContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12).isActive = true
        headerViewContainer.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        headerViewContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        
        headerViewContainer.addArrangedSubview(headerunderlineView)
        headerViewContainer.addArrangedSubview(headerImageView)
        headerImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerViewContainer.addArrangedSubview(underlineView)
        headerViewContainer.addArrangedSubview(ingredienceLabel)
        headerViewContainer.addArrangedSubview(ingredienceValueLabel)
        headerViewContainer.addArrangedSubview(allergyLabel)
        headerViewContainer.addArrangedSubview(allergyValueLabel)
        
        //Footer
        let footerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 20, width: UIScreen.main.bounds.width, height: 180))
        self.productTableView.tableFooterView = footerView
        footerView.addSubview(totalViewContainer)
        totalViewContainer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor , constant: 12).isActive = true
        totalViewContainer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12).isActive = true
        totalViewContainer.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 12).isActive = true
        totalViewContainer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -12).isActive = true
        
        totalViewContainer.addArrangedSubview(CommentLabel)
        totalViewContainer.addArrangedSubview(messageValue)
        
        messageValue.heightAnchor.constraint(equalToConstant:100).isActive = true
        messageValue.text = "Message"
        messageValue.textColor = UIColor.lightGray
        messageValue.delegate = self
    }
    
    @objc func didTapAddButton(sender: AnyObject) {
        print("Add item")
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //Variable
    let totalViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let CommentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Comments"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let messageValue:UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let headerViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let headerImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .lightGray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let headerunderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    let ingredienceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Ingredience"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ingredienceValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Lamb,Meat,Chicken\nVeg"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let allergyLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Allergies"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let allergyValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "-> Not Allergy\n-> Ordered Allergy"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let footerView = self.productTableView.tableFooterView else {
            return
            
        }
        let width = self.productTableView.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.productTableView.tableFooterView = footerView
        }
        
        guard let headerView = self.productTableView.tableHeaderView else {
            return
            
        }
        let size1 = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size1.height {
            headerView.frame.size.height = size1.height
            self.productTableView.tableHeaderView = headerView
        }
    }
}
// MARK:- UITableView Methods

extension ProductVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductOrder[section].menuValue?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckableTableViewCell", for: indexPath) as! CheckableTableViewCell
        cell.NameLabel.text = arrProductOrder[indexPath.section].menuValue?[indexPath.row]
        if arrProductOrder[indexPath.section].increseDescrese?.count ?? 0 > 0 {
            cell.incdec.setTitle(arrProductOrder[indexPath.section].increseDescrese?[indexPath.row], for: .normal)
        }
        if indexPath.section < arrProductOrder.count - 1{
            cell.btnInc.isHidden = true
            cell.btnDec.isHidden = true
            cell.incDecLabel.isHidden = true
        }else{
            cell.btnInc.isHidden = false
            cell.btnDec.isHidden = false
            cell.btnInc.tag = indexPath.row
            cell.btnInc.addTarget(self, action: #selector(didTapPlusButton(sender:)), for: .touchUpInside)
            cell.incDecLabel.isHidden = false
            cell.incDecLabel.text = arrProductOrder[indexPath.section].incDec?[indexPath.row]
            cell.btnDec.tag = indexPath.row
            cell.btnDec.addTarget(self, action: #selector(didTapMinusButton(sender:)), for: .touchUpInside)
            cell.incdec.tag = indexPath.row
            cell.incdec.addTarget(self, action: #selector(didTapIncDec(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrProductOrder.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90))
        view.backgroundColor =  .white
        let lblname = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 30))
        lblname.font = UIFont.boldSystemFont(ofSize: 20)
        lblname.text = arrProductOrder[section].menuName
        view.addSubview(lblname)
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section < arrProductOrder.count - 1{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    @objc func didTapPlusButton(sender: UIButton) {
        let plusValue = self.arrProductOrder[arrProductOrder.count - 1].incDec?[sender.tag] ?? "0"
        let value = (Double(plusValue) ?? 0.0) + 1
        self.arrProductOrder[arrProductOrder.count - 1].incDec?[sender.tag] = String(format: "%.1f",value)
        let indexPath = IndexPath(item: sender.tag, section: arrProductOrder.count - 1)
        productTableView.reloadRows(at: [indexPath], with: .none)
    }
    @objc func didTapMinusButton(sender: UIButton) {
        let minusValue = self.arrProductOrder[arrProductOrder.count - 1].incDec?[sender.tag] ?? "0"
        var value = (Double(minusValue) ?? 0.0)
        if value > 0{
            if value < 1{
                value = 0.0
            }else{
                value = (Double(minusValue) ?? 0.0) - 1
            }
            self.arrProductOrder[arrProductOrder.count - 1].incDec?[sender.tag] = String(format: "%.1f",value)
            let indexPath = IndexPath(item: sender.tag, section: arrProductOrder.count - 1)
            productTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    @objc func didTapIncDec(sender: UIButton){
        alertWithTextField(title: "Additional item", message: "How many?", placeholder: "Additional item") { [self] result in
            self.arrProductOrder[arrProductOrder.count - 1].increseDescrese?[sender.tag] = result
            let indexPath = IndexPath(item: sender.tag, section: arrProductOrder.count - 1)
            productTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    public func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("0.0") })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result) }
            else
            { completion("0.0") }
        })
        navigationController?.present(alert, animated: true)
    }
}
extension ProductVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
}
