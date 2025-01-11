//
//  MainVC.swift
//  DesignOfPages
//
//  Created by MacV on 17/12/21.
//

import UIKit

class MainVC: UIViewController  {
    
    var myCollectionView:UICollectionView?
    var arrList = ["ALL\nORDERS", "NEW\nORDERS" , "MENU" , "TABLES"]
    var arrColor = [UIColor.purple,UIColor.orange,UIColor.systemCyan,UIColor.green]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let view = UIView()
        view.backgroundColor = .white
        //Exit
        let btnExit = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(Exitaction(_ :)))
        btnExit.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnExit
        let adminButton   = UIBarButtonItem(title: "Admin",  style: .plain, target: self, action: #selector(didTapAdminButton))

        self.navigationItem.rightBarButtonItem = adminButton
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        myCollectionView?.backgroundColor = UIColor.white
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        self.view = view
    }
    @objc func Exitaction(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
    }
    @objc func didTapAdminButton(sender: AnyObject) {
        //Admin
    }
}
extension MainVC:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath as IndexPath) as! MyCollectionViewCell
        
        myCell.backgroundColor = arrColor[indexPath.row].withAlphaComponent(0.6)
        myCell.layer.masksToBounds = true
        myCell.layer.cornerRadius = 10
        myCell.nameLabel.text = arrList[indexPath.row]
        return myCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: self.view.bounds.width / 3 - 10 , height: self.view.bounds.width / 3 - 20 )
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc = UIViewController()
        switch (indexPath.row){
        case 0:
            vc = AllOrdersVC()
        case 1:
            vc = NewOrderListVC()
        case 2:
            vc = MenuOrderVC()
        default:
            vc = NewOrderListVC()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
