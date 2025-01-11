//
//  Extension+CollectionView.swift
//  ScanQR
//
//  Created by MacV on 05/01/22.
//

import Foundation
import UIKit
class ContentSizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
class collectionviewHeaderClass: UICollectionReusableView {
    // MARK:- Variable Declaration
    let mainViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    let moreViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let createQR: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: propHeight * 0.022)
        label.textColor = UIColor.black
        label.text = "Create QR"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    let more:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: propHeight * 0.022)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle("MORE\t", for: .normal)
        btn.contentHorizontalAlignment = .right;
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    // MARK:- Common Methods
    func addViews(){
        addSubview(mainViewContainer)
        mainViewContainer.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:2).isActive = true
        mainViewContainer.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-2).isActive = true
        mainViewContainer.topAnchor.constraint(equalTo:self.topAnchor, constant:5).isActive = true
        mainViewContainer.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: 0).isActive = true
        mainViewContainer.addArrangedSubview(moreViewContainer)
        moreViewContainer.addArrangedSubview(createQR)
        moreViewContainer.addArrangedSubview(more)
        mainViewContainer.addArrangedSubview(underlineView)
        
        createQR.leadingAnchor.constraint(equalTo: moreViewContainer.leadingAnchor, constant: 10).isActive = true
        more.trailingAnchor.constraint(equalTo: moreViewContainer.trailingAnchor, constant: 10).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
