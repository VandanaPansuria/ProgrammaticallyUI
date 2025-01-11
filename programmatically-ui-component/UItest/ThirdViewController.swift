//
//  ThirdViewController.swift
//  UItest
//
//  Created by MacV on 9/24/21.
//

import UIKit
import QuartzCore

class ThirdViewController: UIViewController , UITextViewDelegate{

    let screenWidth = UIScreen.main.bounds.width
    var placeholderLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Book appointment"
        let button1 = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(action(_ :)))
        self.navigationItem.leftBarButtonItem  = button1
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(viewDetail)
        viewDetail.addSubview(dateViewContainer)
        dateViewContainer.addArrangedSubview(timeView)
        time.text = "TIME"
        timeView.addSubview(time)
       
        timeView.addSubview(timeValue)
        date.text = "DATE"
        dateView.addSubview(date)
       
        dateView.addSubview(dateValue)
        dateViewContainer.addArrangedSubview(dateView)
        yourInfo.text = "Your Info"
        viewDetail.addSubview(yourInfo)
        name.text = "Name : "
        viewDetail.addSubview(name)
        txtName.placeholder = "Enter Name"
        viewDetail.addSubview(txtName)
        address.text = "Address : "
        viewDetail.addSubview(address)
        txtAddress.placeholder = "Enter Address"
        viewDetail.addSubview(txtAddress)
        mobile.text = "Mobile : "
        viewDetail.addSubview(mobile)
        txtMobile.placeholder = "Enter Mobile"
        viewDetail.addSubview(txtMobile)
        jobDescription.text = "Job Description"
        viewDetail.addSubview(jobDescription)
        txtView.insertTextPlaceholder(with: CGSize(width: 10, height: 10))
        viewDetail.addSubview(txtView)
        submit.setTitle("Submit Request", for: .normal)
        viewDetail.addSubview(submit)
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
        
        dateViewContainer.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor).isActive = true
        dateViewContainer.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor).isActive = true
        dateViewContainer.topAnchor.constraint(equalTo: viewDetail.topAnchor, constant: 20).isActive = true
        dateViewContainer.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        time.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 10).isActive = true
        time.trailingAnchor.constraint(equalTo: timeView.trailingAnchor).isActive = true
        time.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 20).isActive = true
        time.centerXAnchor.constraint(equalTo:self.timeView.centerXAnchor).isActive = true
        
        timeValue.topAnchor.constraint(equalTo: time.topAnchor, constant: 20).isActive = true
        timeValue.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 20).isActive = true
        timeValue.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -20).isActive = true
        timeValue.heightAnchor.constraint(equalToConstant:24).isActive = true
        
        date.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 10).isActive = true
        date.trailingAnchor.constraint(equalTo: dateView.trailingAnchor).isActive = true
        date.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 20).isActive = true
        date.centerXAnchor.constraint(equalTo:self.dateView.centerXAnchor).isActive = true
        
        dateValue.topAnchor.constraint(equalTo: date.topAnchor, constant: 20).isActive = true
        dateValue.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 20).isActive = true
        dateValue.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -20).isActive = true
        dateValue.heightAnchor.constraint(equalToConstant:24).isActive = true
        
        yourInfo.topAnchor.constraint(equalTo: dateViewContainer.bottomAnchor, constant: 15).isActive = true
        yourInfo.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor, constant: 10).isActive = true
        yourInfo.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor, constant: -10).isActive = true
        
        name.topAnchor.constraint(equalTo: yourInfo.bottomAnchor, constant: 15).isActive = true
        name.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor, constant: 10).isActive = true
        name.widthAnchor.constraint(equalToConstant:65).isActive = true
        txtName.topAnchor.constraint(equalTo: yourInfo.bottomAnchor, constant: 15).isActive = true
        txtName.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 2).isActive = true
        txtName.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor, constant: -10).isActive = true
        txtName.heightAnchor.constraint(equalToConstant:24).isActive = true
       
        address.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        address.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor, constant: 10).isActive = true
        address.widthAnchor.constraint(equalToConstant:65).isActive = true
        txtAddress.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        txtAddress.leadingAnchor.constraint(equalTo: address.trailingAnchor, constant: 2).isActive = true
        txtAddress.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor, constant: -10).isActive = true
        txtAddress.heightAnchor.constraint(equalToConstant:24).isActive = true
        
        mobile.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 15).isActive = true
        mobile.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor, constant: 10).isActive = true
        mobile.widthAnchor.constraint(equalToConstant:65).isActive = true
        txtMobile.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 15).isActive = true
        txtMobile.leadingAnchor.constraint(equalTo: mobile.trailingAnchor, constant: 2).isActive = true
        txtMobile.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor, constant: -10).isActive = true
        txtMobile.heightAnchor.constraint(equalToConstant:24).isActive = true
        
        jobDescription.topAnchor.constraint(equalTo: mobile.bottomAnchor, constant: 30).isActive = true
        jobDescription.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor, constant: 10).isActive = true
        jobDescription.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor, constant: -10).isActive = true
        
        txtView.topAnchor.constraint(equalTo: jobDescription.bottomAnchor, constant: 20).isActive = true
        txtView.leadingAnchor.constraint(equalTo: viewDetail.leadingAnchor, constant: 10).isActive = true
        txtView.trailingAnchor.constraint(equalTo: viewDetail.trailingAnchor, constant: -10).isActive = true
        txtView.heightAnchor.constraint(equalToConstant:90).isActive = true
        
        submit.topAnchor.constraint(equalTo: txtView.bottomAnchor, constant: 20).isActive = true
        submit.widthAnchor.constraint(equalToConstant:140).isActive = true
        submit.centerXAnchor.constraint(equalTo:self.viewDetail.centerXAnchor).isActive = true
        submit.heightAnchor.constraint(equalToConstant:45).isActive = true
        submit.addTarget(self, action: #selector(handleSubmit(sender:)), for: .touchUpInside)

        //done button
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.txtView.inputAccessoryView = toolbar
        self.txtName.inputAccessoryView = toolbar
        self.txtAddress.inputAccessoryView = toolbar
        self.txtMobile.inputAccessoryView = toolbar
      
        self.timeValue.datePicker(target: self,
                                  doneAction: #selector(doneAction),
                                  cancelAction: #selector(cancelAction),
                                  datePickerMode: .time)
        self.dateValue.datePicker(target: self,
                                  doneAction: #selector(dateDoneAction),
                                  cancelAction: #selector(dateCancelAction),
                                  datePickerMode: .date)
        txtName.addPadding(.left(3))
        txtAddress.addPadding(.left(3))
        txtMobile.addPadding(.left(3))
        
        //placeholder
        txtView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Description..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (txtView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        txtView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !txtView.text.isEmpty
        txtView.text = txtView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        txtView.deleteBackward()
        
        timeValue.placeholder = "Select Time"
        dateValue.placeholder = "Select Date"
    }
   
    @objc
    func cancelAction() {
        self.timeValue.resignFirstResponder()
    }
    @objc
    func dateCancelAction() {
        self.dateValue.resignFirstResponder()
    }
    @objc
    func dateDoneAction() {
         if let datePickerView = self.dateValue.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd, MMM"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.dateValue.text = dateString
            self.dateValue.resignFirstResponder()
            
        }
    }
    @objc func doneAction() {
        if let datePickerView = self.timeValue.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.timeValue.text = dateString
            self.timeValue.resignFirstResponder()
        }
    }
    @objc func handleSubmit(sender: UIButton){
        //submit
    }
    @objc func action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func doneButtonAction() {
       self.view.endEditing(true)
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
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
    let dateViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewDetail: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 600).isActive = true
        return view
    }()
    let timeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let time:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeValue:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.textAlignment = .center
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let date:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateValue:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.textAlignment = .center
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let yourInfo:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
    let address:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let mobile:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobDescription:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let txtView:UITextView = {
        let txtView = UITextView()
        txtView.font = UIFont.boldSystemFont(ofSize: 14)
        txtView.textColor =  .black
        txtView.layer.borderColor = UIColor.black.cgColor
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        //txtView.beginFloatingCursor(at: CGPoint(x: 10.0, y: 10.0))
        return txtView
    }()
    let submit:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 4.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let txtName:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor =  .black
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    let txtAddress:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor =  .black
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    let txtMobile:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor =  .black
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
}
