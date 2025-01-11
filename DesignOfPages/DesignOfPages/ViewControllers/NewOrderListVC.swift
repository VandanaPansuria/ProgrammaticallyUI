//
//  NewOrderListVC.swift
//  DesignOfPages
//
//  Created by MacV on 18/12/21.
//

import UIKit

class NewOrderListVC: UIViewController {

    let newOrderTableView = UITableView()
    private var arrnewOrder: [newOrderModel] = [
        newOrderModel(tableName: "Table 1", newOrderPlaced: "22:15", time: "1m 36sec",numberofpeoples: "2 people"),
        newOrderModel(tableName: "Table 2", newOrderPlaced: "19:22", time: "25 sec",numberofpeoples: "4 people"),
        newOrderModel(tableName: "Table 3", newOrderPlaced: "Empty", time: "",numberofpeoples: "5 people"),
        newOrderModel(tableName: "Table 4", newOrderPlaced: "Empty", time: "",numberofpeoples: "2 people")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "New Orders"
        self.view.backgroundColor = .white
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        
        //TableView
        view.addSubview(newOrderTableView)
       
        newOrderTableView.translatesAutoresizingMaskIntoConstraints = false
        newOrderTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        newOrderTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        newOrderTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        newOrderTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        newOrderTableView.dataSource = self
        newOrderTableView.delegate = self
        newOrderTableView.register(newOrderCell.self, forCellReuseIdentifier: "newOrderCell")
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func Contactaction(_ sender: UIButton) {
       // let vc = ContactUsVC()
        //self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK:- UITableView Methods
extension NewOrderListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrnewOrder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard arrnewOrder.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: newOrderCell.identifier, for: indexPath) as? newOrderCell else {
                  return UITableViewCell()
              }
        let newOrderInfo = arrnewOrder[indexPath.row]
        cell.configureData(newOrderInfo: newOrderInfo)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MenuOrderVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
