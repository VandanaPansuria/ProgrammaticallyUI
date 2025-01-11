//
//  UIView+Extension.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import Foundation
import UIKit
extension UIView {
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}
