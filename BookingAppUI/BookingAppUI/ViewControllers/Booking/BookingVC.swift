//
//  BookingVC.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import UIKit

class BookingVC: UIViewController {

   //Variable
    lazy var bookingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = #colorLiteral(red: 0.9174978137, green: 0.917640388, blue: 0.9347547889, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var arrBooking: [BookingModel] = [
        BookingModel(storeName: "Store Name", time: "2021-11-24", orderPlaced: "924", day: "17 november 2021"),
        BookingModel(storeName: "Maysoum Restaurant", time: "2021-11-23", orderPlaced: "925", day: "17 november 2021")
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Booking"
        self.view.backgroundColor = .white
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        
        //Right ContactUS
        let btnContact = UIBarButtonItem(title:"Contact US", style: .plain, target: self, action: #selector(Contactaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.rightBarButtonItem  = btnContact
        
        //TableView
        view.addSubview(bookingTableView)
       
        bookingTableView.translatesAutoresizingMaskIntoConstraints = false
        bookingTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        bookingTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bookingTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        bookingTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bookingTableView.dataSource = self
        bookingTableView.delegate = self
        bookingTableView.register(BookingCell.self, forCellReuseIdentifier: "BookingCell")
    }
    @objc func Backaction(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
    }
    @objc func Contactaction(_ sender: UIButton) {
        let vc = ContactUsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func editAction(_ sender: UIButton) {
        let vc = PickUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK:- UITableView Methods

extension BookingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBooking.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard arrBooking.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.identifier, for: indexPath) as? BookingCell else {
                  return UITableViewCell()
              }
        let bookingInfo = arrBooking[indexPath.row]
        cell.configureData(bookingInfo: bookingInfo)
        cell.bookingEdit.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = StoreNameVC()
        vc.bookingInfo = arrBooking[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
