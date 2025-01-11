//
//  MoreItemVC.swift
//  ScanQR
//
//  Created by MacV on 04/01/22.
//

import UIKit

class MoreItemVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create QR"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.backgroundColor = .white
        view.addSubview(mainViewContainer)
        
        mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        mainViewContainer.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainViewContainer.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        mainViewContainer.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        mainViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainViewContainer.backgroundColor = .white
        mainViewContainer.addSubview(viewContainer)
        viewContainer.topAnchor.constraint(equalTo:mainViewContainer.topAnchor, constant: 5).isActive = true
        viewContainer.leftAnchor.constraint(equalTo:mainViewContainer.leftAnchor, constant: 5).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo:mainViewContainer.trailingAnchor, constant: -5).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo:mainViewContainer.bottomAnchor, constant: -5).isActive = true
        
        
        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        
        viewContainer.addArrangedSubview(myCollectionView)
        mainViewContainer.layer.cornerRadius = 8
        mainViewContainer.layer.masksToBounds = true
    }
    lazy var myCollectionView: ContentSizedCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 80)
        let cv = ContentSizedCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = #colorLiteral(red: 0.9489265084, green: 0.949085772, blue: 0.9704096913, alpha: 1)
        return cv
    }()
    let viewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fill
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let mainViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.backgroundColor = #colorLiteral(red: 0.9489265084, green: 0.949085772, blue: 0.9704096913, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
extension MoreItemVC:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath as IndexPath) as! MyCollectionViewCell
        
        myCell.layer.masksToBounds = true
        myCell.layer.cornerRadius = 10
        myCell.itemImageView.image = arrImageList[indexPath.row]
        myCell.title.text = arrList[indexPath.row]
        return myCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: self.view.bounds.width / 4 - 20 , height: self.view.bounds.width / 4 - 20 )
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row : \(indexPath.row)")
    }
}
