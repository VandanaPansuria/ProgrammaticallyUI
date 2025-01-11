//
//  itemsModel.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import Foundation

struct itemsModel {
    let quantity: String
    let name: String
    let price: String
    static var empty:itemsModel {
           return {
               itemsModel(quantity: "", name: "", price: "")
            }()
    }
}
