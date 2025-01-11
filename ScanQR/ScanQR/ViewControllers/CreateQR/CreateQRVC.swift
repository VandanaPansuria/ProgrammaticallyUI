//
//  CreateQRVC.swift
//  ScanQR
//
//  Created by MacV on 04/01/22.
//

import UIKit
var arrList = ["Email", "Message" , "Telephone" , "Link","Text","Location","WiFi","App Store","Twitter","Facebook","Instagram","Youtube","Telegram","Snapchat","Whatsapp","Viber","Pinterest","VK","TikTok","Tumblr","Spotify","Sound","Apple Music","iClould"]
var arrImageList = [#imageLiteral(resourceName: "mail"), #imageLiteral(resourceName: "telephone_260e-fe0f 2") , #imageLiteral(resourceName: "dialer") , #imageLiteral(resourceName: "telephone_260e-fe0f 1") , #imageLiteral(resourceName: "telephone_260e-fe0f 1 (1)"), #imageLiteral(resourceName: "maps"), #imageLiteral(resourceName: "telephone_260e-fe0f 1 (2)"), #imageLiteral(resourceName: "appstore") , #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "inst") , #imageLiteral(resourceName: "Youtube"), #imageLiteral(resourceName: "Telegram"), #imageLiteral(resourceName: "snapchat"), #imageLiteral(resourceName: "whatsapp"), #imageLiteral(resourceName: "viber"), #imageLiteral(resourceName: "Pinterest"), #imageLiteral(resourceName: "vk"), #imageLiteral(resourceName: "tiktok"), #imageLiteral(resourceName: "tumblr-1"), #imageLiteral(resourceName: "spotify"), #imageLiteral(resourceName: "soundcloud"), #imageLiteral(resourceName: "music"), #imageLiteral(resourceName: "icloud") ]

class CreateQRVC: UIViewController {
    
    //Variable
    lazy var myCollectionView: ContentSizedCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        //layout.itemSize = CGSize(width: self.view.frame.width, height: 80)
        let cv = ContentSizedCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        // cv.backgroundColor = #colorLiteral(red: 0.9174978137, green: 0.917640388, blue: 0.9347547889, alpha: 1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create QR"
        // self.view.backgroundColor = .white
        self.view.backgroundColor = #colorLiteral(red: 0.9174978137, green: 0.917640388, blue: 0.9347547889, alpha: 1)
        
        //TableView
        self.view.addSubview(myCollectionView)
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        
        myCollectionView.register(collectionviewHeaderClass.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "collectionviewHeaderClass")
        
        myCollectionView.layer.cornerRadius = 10
        myCollectionView.layer.masksToBounds = true
    }
    @objc func moreAction(_ sender: UIButton) {
        let vc = MoreItemVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension CreateQRVC:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: propHeight * 0.06)
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
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionviewHeaderClass", for: indexPath) as? collectionviewHeaderClass
            headerView?.more.addTarget(self, action: #selector(moreAction(_:)), for: .touchUpInside)
            return headerView!
        default:
            assert(false, "Unexpected element kind")
        }
    }
}
