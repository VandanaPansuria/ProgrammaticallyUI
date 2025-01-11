//
//  Extension+UITextField.swift
//  UItest
//
//  Created by MacV on 9/27/21.
//
import UIKit
import Foundation
extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
    enum PaddingSide {
            case left(CGFloat)
            case right(CGFloat)
            case both(CGFloat)
        }

        func addPadding(_ padding: PaddingSide) {

            self.leftViewMode = .always
            self.layer.masksToBounds = true


            switch padding {

            case .left(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.leftView = paddingView
                self.rightViewMode = .always

            case .right(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.rightView = paddingView
                self.rightViewMode = .always

            case .both(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                // left
                self.leftView = paddingView
                self.leftViewMode = .always
                // right
                self.rightView = paddingView
                self.rightViewMode = .always
            }
        }
}
