//
//  FirstViewController.swift
//  UItest
//
//  Created by MacV on 9/24/21.
//

import UIKit

class FirstViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    //variable
    var groceries = GroceriesAPI.getData() // model
    let myTableView = UITableView()
    lazy var searchBar:UISearchBar = UISearchBar()
    var isSearch : Bool = false
    var filteredTableData:[Health] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let button1 = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(action(_ :)))
        self.navigationItem.leftBarButtonItem  = button1
        
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 50))
        headerView.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        
        let items = ["Groceries", "Health & Wellness", "Appointment"]
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
        
        self.myTableView.tableHeaderView = headerView
        view.addSubview(myTableView)
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(myTableViewCell.self, forCellReuseIdentifier: "contactCell")
        
        //search bar
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    
    }
    //Segment value changed
    @objc func changeSegmentValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            groceries = GroceriesAPI.getData()
        case 1:
            groceries = HealthAPI.getData()
        case 2:
            groceries = AppointmentAPI.getData()
        default:
            print(sender.selectedSegmentIndex)
        }
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
            self.searchBar.text = ""
            self.isSearch = false
            self.myTableView.reloadData()
        }
    }
    @objc func action(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- TableViewDelegate
extension FirstViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch) {
            return filteredTableData.count
        }else{
            return groceries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! myTableViewCell
        cell.health = isSearch ? filteredTableData[indexPath.row] : groceries[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(isSearch)
        let titlename = isSearch ? filteredTableData[indexPath.row].name ?? "" : groceries[indexPath.row].name ?? ""
       
        let vc = SecondViewController()
        vc.screentitle = titlename
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- UISearchBarDelegate
extension FirstViewController: UISearchBarDelegate{
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTableData = groceries.filter { $0.itemname!.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()}
        isSearch = true
        self.myTableView.reloadData()
    }
}
