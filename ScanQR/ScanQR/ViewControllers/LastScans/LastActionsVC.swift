//
//  LastActionsVC.swift
//  ScanQR
//
//  Created by MacV on 04/01/22.
//

import UIKit

class LastActionsVC: UITableViewController {
    
    // MARK: - Properties
    private var scrollAndSelectController: TableViewSelectionController!
    private var EditBarButtonItem: UIBarButtonItem!
    private var DoneBarButtonItem: UIBarButtonItem!
    private var SelectAllBarButtonItem: UIBarButtonItem!
    private var cells = [[Int]]()
    private var arrList: [LastScanModel] = [
        LastScanModel(barcode: "Barcode 45435435343", time: "Barcode 28:03:2020, 02:21 pm"),
        LastScanModel(barcode: "Barcode 3245345455", time: "Barcode 28:03:2020, 02:21 pm"),
        LastScanModel(barcode: "Barcode 45435435343", time: "Barcode 28:03:2020, 02:21 pm"),
        LastScanModel(barcode: "Barcode 3245345455", time: "Barcode 28:03:2020, 02:21 pm"),
        LastScanModel(barcode: "Barcode 45435435343", time: "Barcode 28:03:2020, 02:21 pm"),
        LastScanModel(barcode: "Barcode 3245345455", time: "Barcode 28:03:2020, 02:21 pm")
    ]
    // MARK: - Memory Management
    deinit {
        scrollAndSelectController?.invalidate()
        scrollAndSelectController = nil
    }
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Last Scans"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.view.backgroundColor = .white
        // IMPORTANT
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.isScrollEnabled = true
        tableView.backgroundColor = #colorLiteral(red: 0.9174978137, green: 0.917640388, blue: 0.9347547889, alpha: 1)
        // Instantiate
        scrollAndSelectController = TableViewSelectionController(tableView: tableView, scrollingSpeed: .moderate)
        
        // Set up dummy cells
        reloadCells()
        
        // Configure navigation bar
        DoneBarButtonItem   = UIBarButtonItem(title : "Done",  style: .plain, target: self, action: #selector(didTapDoneButton))
        
        SelectAllBarButtonItem   = UIBarButtonItem(title : "Select All",  style: .plain, target: self, action: #selector(didTapSelectAllButton))
        
        EditBarButtonItem   = UIBarButtonItem(image: UIImage(named: "edit"),  style: .plain, target: self, action: #selector(didTapEditButton))
        
        self.navigationItem.rightBarButtonItem = EditBarButtonItem
        
        updateNavBarForSelection()
        tableView.register(ScanCell.self, forCellReuseIdentifier: "ScanCell")
        
        self.view.addSubview(delete)
        delete.isUserInteractionEnabled = false
        
        //set constrains
        delete.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            delete.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
            delete.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
            delete.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:0).isActive = true
        } else {
            delete.leftAnchor.constraint(equalTo: tableView.layoutMarginsGuide.leftAnchor, constant: 0).isActive = true
            delete.rightAnchor.constraint(equalTo: tableView.layoutMarginsGuide.rightAnchor, constant: 0).isActive = true
            delete.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        }
        delete.heightAnchor.constraint(equalToConstant: 80).isActive = true
        delete.addTarget(self, action: #selector(didTapDeleteButton(sender:)), for: .touchUpInside)
    }
    @objc func didTapDeleteButton(sender: AnyObject) {
        let alert = UIAlertController(title: "Are you sure?", message: "Selected file(s) will be deleted. This action cannot be undone", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            self.deselectAllRow()
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction!) in
            self.arrList.removeAll()
            self.tableView.reloadData()
            self.delete.isUserInteractionEnabled = false
            self.delete.alpha = 0.4
            self.setEditing(false, animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func deselectAllRow(){
        for section in 0..<self.tableView.numberOfSections {
            for row in 0..<self.tableView.numberOfRows(inSection: section) {
                self.tableView.deselectRow(at: IndexPath(row: row, section: section), animated: false)
            }
        }
        self.delete.isUserInteractionEnabled = false
        self.delete.alpha = 0.4
    }
    @objc func didTapDoneButton(sender: AnyObject) {
        navigationItem.title = "Last Scans"
        self.setEditing(false, animated: true)
        self.deselectAllRow()
    }
    @objc func didTapEditButton(sender: AnyObject) {
        self.setEditing(true, animated: true)
    }
    @objc func didTapSelectAllButton(sender: AnyObject) {
        for section in 0..<tableView.numberOfSections {
            for row in 0..<tableView.numberOfRows(inSection: section) {
                tableView.selectRow(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .none)
            }
        }
        delete.isUserInteractionEnabled = true
        delete.alpha = 1.0
    }
    let delete:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.red, for: .normal)
        btn.alpha = 0.4
        btn.setTitle("DELETE\t", for: .normal)
        btn.contentHorizontalAlignment = .right;
        btn.backgroundColor = #colorLiteral(red: 0.9763746858, green: 0.9765380025, blue: 0.9806585908, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return btn
    }()
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    // MARK: - Actions
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        scrollAndSelectController.enabled = editing
        navigationItem.rightBarButtonItem = editing ? DoneBarButtonItem : EditBarButtonItem
        
        navigationItem.leftBarButtonItem = editing ? SelectAllBarButtonItem : .none
    }
    
    @objc private func toggleDebugMode(_ sender: Any) {
        scrollAndSelectController.setDebugMode(on: !scrollAndSelectController.isInDebugMode)
    }
    
    private func reloadCells() {
        
        cells.removeAll()
        for row in 0..<arrList.count {
            if row == 0 {
                cells.append([0])
            }
        }
        tableView.reloadData()
    }
    
    private func updateNavBarForSelection() {
        if isEditing {
            let selectionCount = tableView.indexPathsForSelectedRows?.count ?? 0
            navigationItem.title = "Selected: \(selectionCount)"
            if selectionCount > 0{
                delete.isUserInteractionEnabled = true
                delete.alpha = 1.0
            }else{
                delete.isUserInteractionEnabled = false
                delete.alpha = 0.4
            }
        } else {
            navigationItem.title = "Last Scans"
        }
    }
    // MARK: - Table view data source / delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard arrList.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: ScanCell.identifier, for: indexPath) as? ScanCell else {
                  return UITableViewCell()
              }
        let info = arrList[indexPath.row]
        cell.configureData(ScanInfo: info)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateNavBarForSelection()
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateNavBarForSelection()
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recents"
    }
}
