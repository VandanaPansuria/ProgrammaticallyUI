//
//  TableViewCell.swift
//  ScanQR
//
//  Created by MacV on 05/01/22.
//

import Foundation
import UIKit

class ScanCell: UITableViewCell {
    // MARK:- Variable Declaration
    let ScanDetailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let ScanViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    let BarcodeNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? propWidth * 0.12 : 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? propWidth * 0.12 : 12)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        return img
    }()
    static let identifier = String(describing: ScanCell.self)
    
    // MARK:- Common Methods
    func configureData(ScanInfo: LastScanModel) {
        iconImageView.image = UIImage(named: "barcode")
        BarcodeNameLabel.text = ScanInfo.barcode
        timeLabel.text = "\(ScanInfo.time)"
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(ScanDetailViewContainer)
        
        ScanDetailViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        ScanDetailViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        ScanDetailViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:12).isActive = true
        ScanDetailViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -12).isActive = true
        ScanDetailViewContainer.addArrangedSubview(iconImageView)
        ScanDetailViewContainer.addArrangedSubview(ScanViewContainer)
        
        ScanViewContainer.addArrangedSubview(BarcodeNameLabel)
       
        ScanViewContainer.addArrangedSubview(timeLabel)
       
        iconImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        iconImageView.topAnchor.constraint(equalTo: ScanDetailViewContainer.topAnchor, constant: 10).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: ScanDetailViewContainer.bottomAnchor, constant: -10).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: ScanDetailViewContainer.leadingAnchor, constant: 10).isActive = true
       
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class HeaderCell: UITableViewCell {
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
    let lastScan: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? propWidth * 0.12 : 16)
        label.textColor = UIColor.black
        label.text = "LAST SCANS"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    let more:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? propWidth * 0.12 : 12)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle("MORE\t", for: .normal)
        btn.contentHorizontalAlignment = .right;
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    static let identifier = String(describing: HeaderCell.self)
    
    // MARK:- Common Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(mainViewContainer)
        
        mainViewContainer.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:2).isActive = true
        mainViewContainer.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-2).isActive = true
        mainViewContainer.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:5).isActive = true
        mainViewContainer.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: 0).isActive = true
        mainViewContainer.addArrangedSubview(moreViewContainer)
    
        moreViewContainer.addArrangedSubview(lastScan)
        moreViewContainer.addArrangedSubview(more)
        mainViewContainer.addArrangedSubview(underlineView)
        
        lastScan.leadingAnchor.constraint(equalTo: moreViewContainer.leadingAnchor, constant: 10).isActive = true
        more.trailingAnchor.constraint(equalTo: moreViewContainer.trailingAnchor, constant: 10).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
