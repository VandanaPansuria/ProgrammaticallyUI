//
//  LastScanVC.swift
//  ScanQR
//
//  Created by MacV on 04/01/22.
//

import UIKit

class LastScanVC: UIViewController {
    
    //Variable
    lazy var scanTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = #colorLiteral(red: 0.9174978137, green: 0.917640388, blue: 0.9347547889, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var arrList: [LastScanModel] = [
        LastScanModel(barcode: "", time: ""),
        LastScanModel(barcode: "Barcode 45435435343", time: "Barcode 28:03:2020, 02:21 pm"),
        LastScanModel(barcode: "Barcode 3245345455", time: "Barcode 28:03:2020, 02:21 pm")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Last Scans"
        self.view.backgroundColor = .white
        
        //TableView
        view.addSubview(scanTableView)
        
        scanTableView.translatesAutoresizingMaskIntoConstraints = false
        scanTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        scanTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scanTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scanTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scanTableView.dataSource = self
        scanTableView.delegate = self
        scanTableView.register(ScanCell.self, forCellReuseIdentifier: "ScanCell")
        scanTableView.register(HeaderCell.self,forCellReuseIdentifier: "HeaderCell")
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: propHeight * 0.06))
        self.scanTableView.tableHeaderView = headerView
    }
    @objc func moreAction(_ sender: UIButton) {
        let vc = LastActionsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK:- UITableView Methods

extension LastScanVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else {
                return UITableViewCell()
            }
            cell.more.addTarget(self, action: #selector(moreAction(_:)), for: .touchUpInside)
            return cell
        }else{
            guard arrList.indices.contains(indexPath.row),
                  let cell = tableView.dequeueReusableCell(withIdentifier: ScanCell.identifier, for: indexPath) as? ScanCell else {
                      return UITableViewCell()
                  }
            let info = arrList[indexPath.row]
            cell.configureData(ScanInfo: info)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row : \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
