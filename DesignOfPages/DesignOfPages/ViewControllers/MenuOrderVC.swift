//
//  MenuOrderVC.swift
//  DesignOfPages
//
//  Created by MacV on 18/12/21.
//

import UIKit

class MenuOrderVC: UIViewController {
    
    let menuOrderTableView = UITableView()
    var menuOrder = [MenuOrder]()
    var subMenuOrder = [SubMenuOrder]()
    var lbl = UILabel()
    var customSC = UISegmentedControl()
    var subCustomSC = UISegmentedControl()
    let items = ["All","Starter","Burgers","Drinks","Pizza"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Menu Order"
        self.view.backgroundColor = .white
        
        allSegment()
        
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        
        //Header
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 50))
        headerView.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        
        customSC = UISegmentedControl(items: items)
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
        
        self.menuOrderTableView.tableHeaderView = headerView
        
        //TableView
        view.addSubview(menuOrderTableView)
        
        menuOrderTableView.translatesAutoresizingMaskIntoConstraints = false
        menuOrderTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuOrderTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        menuOrderTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        menuOrderTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        menuOrderTableView.dataSource = self
        menuOrderTableView.delegate = self
        menuOrderTableView.register(menuOrderCell.self, forCellReuseIdentifier: "menuOrderCell")
        
        //navigation bar button
        let optionButton   = UIBarButtonItem(title: "Option",  style: .plain, target: self, action: #selector(didTapOptionButton))
        let checkoutButton   = UIBarButtonItem(title: "Checkout",  style: .plain, target: self, action: #selector(didTapCheckoutButton))

        self.navigationItem.rightBarButtonItem = checkoutButton
    }
    func allSegment(){
        menuOrder.append(MenuOrder.init(orderMenuName: "Starter", orderSubMenuName: [SubMenuOrder.init(menuName: "Spanish", menuValue: ["Kenva","Lemon"]),
         SubMenuOrder.init(menuName: "Indian", menuValue: ["Indian1","Indian2"]),
         SubMenuOrder.init(menuName: "British", menuValue: ["British1","British2","British3"]),
         SubMenuOrder.init(menuName: "French", menuValue: ["French1","French2"])]))
        
        menuOrder.append(MenuOrder.init(orderMenuName: "Burgers", orderSubMenuName: [SubMenuOrder.init(menuName: "Lamb", menuValue: ["Lamb Burger","Beef Burger"]),
            SubMenuOrder.init(menuName: "Chicken", menuValue: ["Indian1","Indian2"]),
             SubMenuOrder.init(menuName: "Quemn", menuValue: ["Quemn1","Quemn2"])]))
        
        menuOrder.append(MenuOrder.init(orderMenuName: "Drinks", orderSubMenuName: [SubMenuOrder.init(menuName: "Soft Drink", menuValue: ["Coke","Pepsi"]),
             SubMenuOrder.init(menuName: "Coffee", menuValue: ["Coffee1","Coffee2"]),
            SubMenuOrder.init(menuName: "Tea", menuValue: ["Tea1","Tea2","Tea3"]),
           SubMenuOrder.init(menuName: "Wine", menuValue: ["Wine1","Wine2"])]))
        
        menuOrder.append(MenuOrder.init(orderMenuName: "Pizza", orderSubMenuName: [SubMenuOrder.init(menuName: "Basic", menuValue: ["Margherita","Tomato No cheese"]),
             SubMenuOrder.init(menuName: "Chicken", menuValue: ["Chicken1","Chicken2"]),
              SubMenuOrder.init(menuName: "Met", menuValue: ["Met1","Met2","Met3"]),
             SubMenuOrder.init(menuName: "Veg", menuValue: ["Veg1","Veg2"])]))
    }
    @objc func didTapOptionButton(sender: AnyObject) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
            @unknown default:
                print("default")
            }
        }))
        self.present(alert, animated: true, completion: nil)
       }
    @objc func didTapCheckoutButton(sender: AnyObject) {
        let vc = OrderOverViewVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //Segment value changed
    @objc func changeSegmentValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            menuOrder = []
            allSegment()
        case 1:
            menuOrder = [MenuOrder.init(orderMenuName: "Starter", orderSubMenuName: [SubMenuOrder.init(menuName: "Spanish", menuValue: ["Kenva","Lemon"]),
             SubMenuOrder.init(menuName: "Indian", menuValue: ["Indian1","Indian2"]),
             SubMenuOrder.init(menuName: "British", menuValue: ["British1","British2","British3"]),
             SubMenuOrder.init(menuName: "French", menuValue: ["French1","French2"])])]
        case 2:
            menuOrder = [MenuOrder.init(orderMenuName: "Burgers", orderSubMenuName: [SubMenuOrder.init(menuName: "Lamb", menuValue: ["Lamb Burger","Beef Burger"]),
                SubMenuOrder.init(menuName: "Chicken", menuValue: ["Indian1","Indian2"]),
                 SubMenuOrder.init(menuName: "Quemn", menuValue: ["Quemn1","Quemn2"])])]
        case 3:
            menuOrder = [MenuOrder.init(orderMenuName: "Drinks", orderSubMenuName: [SubMenuOrder.init(menuName: "Soft Drink", menuValue: ["Coke","Pepsi"]),
                 SubMenuOrder.init(menuName: "Coffee", menuValue: ["Coffee1","Coffee2"]),
                SubMenuOrder.init(menuName: "Tea", menuValue: ["Tea1","Tea2","Tea3"]),
               SubMenuOrder.init(menuName: "Wine", menuValue: ["Wine1","Wine2"])])]
        case 4:
            menuOrder = [MenuOrder.init(orderMenuName: "Pizza", orderSubMenuName: [SubMenuOrder.init(menuName: "Basic", menuValue: ["Margherita","Tomato No cheese"]),
                 SubMenuOrder.init(menuName: "Chicken", menuValue: ["Chicken1","Chicken2"]),
                  SubMenuOrder.init(menuName: "Met", menuValue: ["Met1","Met2","Met3"]),
                 SubMenuOrder.init(menuName: "Veg", menuValue: ["Veg1","Veg2"])])]
        default:
            menuOrder = [MenuOrder.init(orderMenuName: "Starter", orderSubMenuName: [SubMenuOrder.init(menuName: "Spanish", menuValue: ["Kenva","Lemon"]),
             SubMenuOrder.init(menuName: "Indian", menuValue: ["Indian1","Indian2"]),
             SubMenuOrder.init(menuName: "British", menuValue: ["British1","British2","British3"]),
             SubMenuOrder.init(menuName: "French", menuValue: ["French1","French2"])])]
        }
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
             self.menuOrderTableView.reloadData()
        }
    }
    @objc func changeSegmentValue1(sender: UISegmentedControl) {
        UIView.setAnimationsEnabled(false)
        self.menuOrderTableView.beginUpdates()
        self.menuOrderTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableView.RowAnimation.none)
        self.menuOrderTableView.endUpdates()
        subCustomSC.selectedSegmentIndex = sender.selectedSegmentIndex
        lbl.text = menuOrder[0].orderSubMenuName?[subCustomSC.selectedSegmentIndex].menuName
    }
}
// MARK:- UITableView Methods

extension MenuOrderVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // let segmentIndex = subCustomSC.selectedSegmentIndex == -1 ? 0 : subCustomSC.selectedSegmentIndex
        return  menuOrder[section].orderSubMenuName?[0].menuValue?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuOrderCell", for: indexPath) as! menuOrderCell
     //   let segmentIndex = subCustomSC.selectedSegmentIndex == -1 ? 0 : subCustomSC.selectedSegmentIndex
        cell.itemNameLabel.text =  menuOrder[indexPath.section].orderSubMenuName?[0].menuValue?[indexPath.row]
        cell.price.text = "40 QR"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ProductVC()
        vc.itemName = menuOrder[indexPath.section].orderMenuName ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuOrder.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor =  .white
        let lblname = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 30))
        lblname.font = UIFont.boldSystemFont(ofSize: 20)
        lblname.text = menuOrder[section].orderMenuName
        view.addSubview(lblname)
        
        /*subCustomSC = UISegmentedControl(items: menuOrder[section].orderSubMenuName?.map{$0.menuName ?? ""})
        subCustomSC.selectedSegmentIndex = 0
        subCustomSC.frame = CGRect(x: 10, y: 32, width: view.frame.size.width - 20 , height: 35)
        subCustomSC.layer.cornerRadius = 2.0
        subCustomSC.backgroundColor = .lightGray
        subCustomSC.tintColor = UIColor.white
        subCustomSC.addTarget(self, action: #selector(changeSegmentValue1(sender:)), for: .valueChanged)
        view.addSubview(subCustomSC)
        
        lbl = UILabel(frame: CGRect(x: 15, y: 70, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.text = menuOrder[section].orderSubMenuName?[subCustomSC.selectedSegmentIndex].menuName
        view.addSubview(lbl)*/
        
        return view
    }
}
