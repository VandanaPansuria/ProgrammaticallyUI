//
//  ContactUsVC.swift
//  BookingAppUI
//
//  Created by MacV on 04/12/21.
//

import Foundation
import UIKit
class ContactUsVC: UIViewController {

    
    var bookingInfo = BookingModel.empty
    private var arrItems: [itemsModel] = [
        itemsModel(quantity: "2x", name: "samosa", price: "190")
    ]
    let dataArray = ["English", "Maths", "History", "German", "Science"]
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Continue with Email"
        self.view.backgroundColor = .white
        //Back
        let btnBack = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(Backaction(_ :)))
        btnBack.tintColor = .black
        self.navigationItem.leftBarButtonItem  = btnBack
        
        //image
        self.view.addSubview(mainViewContainer)
        
        mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        mainViewContainer.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        mainViewContainer.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        mainViewContainer.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        mainViewContainer.addArrangedSubview(nameViewContainer)
        nameViewContainer.addArrangedSubview(nameValue)
        nameViewContainer.addArrangedSubview(nameView)
        nameValue.heightAnchor.constraint(equalToConstant:45).isActive = true
        mainViewContainer.addArrangedSubview(phoneViewContainer)
        phoneViewContainer.addArrangedSubview(phoneValue)
        phoneViewContainer.addArrangedSubview(phoneView)
        phoneValue.heightAnchor.constraint(equalToConstant:45).isActive = true
        
        mainViewContainer.addArrangedSubview(emailViewContainer)
        emailViewContainer.addArrangedSubview(emailValue)
        emailViewContainer.addArrangedSubview(emailView)
        emailValue.heightAnchor.constraint(equalToConstant:45).isActive = true
        
        mainViewContainer.addArrangedSubview(passwordViewContainer)
        passwordViewContainer.addArrangedSubview(passwordValue)
        passwordViewContainer.addArrangedSubview(passwordView)
        passwordValue.heightAnchor.constraint(equalToConstant:45).isActive = true
        mainViewContainer.addArrangedSubview(messageValue)
        messageValue.heightAnchor.constraint(equalToConstant:80).isActive = true
        mainViewContainer.addArrangedSubview(login)
        login.heightAnchor.constraint(equalToConstant:45).isActive = true
        
        emailValue.placeholder = "Email"
        passwordValue.placeholder = "Password"
        nameValue.placeholder = "Name"
        phoneValue.placeholder = "Phone Number"
        messageValue.text = "Message"
        messageValue.textColor = UIColor.lightGray
        messageValue.delegate = self
        emailValue.addBottomBorder()
        //messageValue.inputView = pickerView
     //   signIn.addTarget(self, action: #selector(troubleAction(_:)), for: .touchUpInside)
    }
    @objc func troubleAction(_ sender: UIButton) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
                
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    @objc func Backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Variable Declaration
    let mainViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    let nameValue:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.borderStyle = UITextField.BorderStyle.none
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let phoneViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let phoneView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    let phoneValue:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.borderStyle = UITextField.BorderStyle.none
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let messageValue:UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let emailViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    let emailValue:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let passwordViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    let passwordValue:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.borderStyle = UITextField.BorderStyle.none
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let login:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.backgroundColor = #colorLiteral(red: 0.1952860653, green: 0.4249241948, blue: 0.5278713703, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Login", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        return btn
    }()
}
extension ContactUsVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
}
extension ContactUsVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return dataArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = dataArray[row]
        return row
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dataArray[row])
    }
}
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
