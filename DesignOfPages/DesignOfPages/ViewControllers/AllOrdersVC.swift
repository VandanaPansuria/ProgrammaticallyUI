//
//  AllOrdersVC.swift
//  DesignOfPages
//
//  Created by MacV on 17/12/21.
//

import UIKit

class AllOrdersVC: UIViewController {
    //Variable
    let orderTableView = UITableView()
    var arrOrder = AllTableOrderAPI.getData()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "All Orders"
        self.view.backgroundColor = .white
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 50))
        headerView.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        
        let items = ["All", "Tables", "Online"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.frame = CGRect(x: 10, y: 5, width: headerView.frame.size.width - 20 , height: 35)
        // Style the Segmented Control
        customSC.layer.cornerRadius = 2.0  // Don't let background bleed
        customSC.backgroundColor = .lightGray
        customSC.tintColor = UIColor.white
        
        // Add target action method
        customSC.addTarget(self, action: #selector(changeSegmentValue(sender:)), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        headerView.addSubview(customSC)
        
        self.orderTableView.tableHeaderView = headerView
        //TableView
        view.addSubview(orderTableView)
       
        orderTableView.translatesAutoresizingMaskIntoConstraints = false
        orderTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        orderTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        orderTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        orderTableView.dataSource = self
        orderTableView.delegate = self
        orderTableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func Contactaction(_ sender: UIButton) {
       // let vc = ContactUsVC()
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func editAction(_ sender: UIButton) {
        let vc = MenuOrderVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //Segment value changed
    @objc func changeSegmentValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            arrOrder = AllTableOrderAPI.getData()
        case 1:
            arrOrder = TableAPI.getData()
        case 2:
            arrOrder = OnlineAPI.getData()
        default:
            print(sender.selectedSegmentIndex)
        }
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
            self.orderTableView.reloadData()
        }
    }
}
// MARK:- UITableView Methods

extension AllOrdersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard arrOrder.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as? OrderCell else {
                  return UITableViewCell()
              }
        let OrderInfo = arrOrder[indexPath.row]
        cell.configureData(OrderInfo: OrderInfo)
        cell.OrderEdit.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = OrderViewVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
