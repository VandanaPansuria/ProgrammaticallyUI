//
//  SecondViewController.swift
//  UItest
//
//  Created by MacV on 9/24/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    var screentitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = screentitle
        let button1 = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(action(_ :)))
        self.navigationItem.leftBarButtonItem  = button1
        
        let button2 = UIBarButtonItem(title: "Book Now", style: .plain, target: self,  action: #selector(bookNow(_ :)))
        self.navigationItem.rightBarButtonItem  = button2
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(viewDetail)
        
        viewDetail.addSubview(profileImageView)
        viewDetail.addSubview(plumber)
        plumber.text = "Plumber (based in A1-rayyan)"
        viewDetail.addSubview(charge)
        charge.text = "Per hour charge : 160 QR"
        viewDetail.addSubview(travel)
        travel.text = "Travel : yes will travel to you"
        viewDetail.addSubview(experience)
        experience.text = "Experience : 5 years"
        viewDetail.addSubview(personalinfo)
        personalinfo.text = "Personal Information"
        viewDetail.addSubview(name)
        name.text = "Name : \(screentitle)"
        viewDetail.addSubview(age)
        age.text = "Age : 28"
        viewDetail.addSubview(gender)
        gender.text = "Gender : MALE"
        viewDetail.addSubview(workingHrs)
        workingHrs.text = "Working hrs : 9:00am-13am"
        viewDetail.addSubview(available)
        available.text = "Available days : Sunday-Thursday"
        viewDetail.addSubview(about)
        about.text = "A little about \(screentitle)"
        //scrollview
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //image
       // profileImageView.topAnchor.constraint(equalTo:self.viewDetail.topAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.viewDetail.topAnchor, constant: 20).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo:self.viewDetail.centerXAnchor).isActive = true
       // profileImageView.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:150).isActive = true
       // plumber.topAnchor.constraint(equalTo:self.itemnameLabel.bottomAnchor).isActive = true
        
        //plumber
        plumber.topAnchor.constraint(equalTo:self.profileImageView.bottomAnchor, constant: 20).isActive = true
        plumber.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        plumber.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        
        //charge
        charge.topAnchor.constraint(equalTo:self.plumber.bottomAnchor, constant: 20).isActive = true
        charge.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        charge.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        
        //travel
        travel.topAnchor.constraint(equalTo:self.charge.bottomAnchor, constant: 10).isActive = true
        travel.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        travel.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        
        //experience
        experience.topAnchor.constraint(equalTo:self.travel.bottomAnchor, constant: 10).isActive = true
        experience.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        experience.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        
        //info
        personalinfo.topAnchor.constraint(equalTo:self.experience.bottomAnchor, constant: 30).isActive = true
        personalinfo.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        personalinfo.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        //name
        name.topAnchor.constraint(equalTo:self.personalinfo.bottomAnchor, constant: 20).isActive = true
        name.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        //age
        age.topAnchor.constraint(equalTo:self.name.bottomAnchor, constant: 10).isActive = true
        age.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        age.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        //gender
        gender.topAnchor.constraint(equalTo:self.age.bottomAnchor, constant: 10).isActive = true
        gender.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        gender.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        //working
        workingHrs.topAnchor.constraint(equalTo:self.gender.bottomAnchor, constant: 10).isActive = true
        workingHrs.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        workingHrs.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        //available
        available.topAnchor.constraint(equalTo:self.workingHrs.bottomAnchor, constant: 10).isActive = true
        available.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        available.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
        //about
        about.topAnchor.constraint(equalTo:self.available.bottomAnchor, constant: 10).isActive = true
        about.leadingAnchor.constraint(equalTo:self.viewDetail.leadingAnchor, constant: 10).isActive = true
        about.trailingAnchor.constraint(equalTo:self.viewDetail.trailingAnchor, constant: -10).isActive = true
    }
    @objc func action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func bookNow(_ sender: UIButton) {
        let vc = ThirdViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewDetail: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 600).isActive = true
        return view
    }()
    
  
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .brown
        return img
    }()
    let plumber:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let charge:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let travel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let experience:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let personalinfo:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let name:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let age:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let gender:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let workingHrs:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let available:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let about:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
