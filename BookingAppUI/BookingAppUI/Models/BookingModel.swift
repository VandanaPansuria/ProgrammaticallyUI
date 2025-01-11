//
//  BookingModel.swift
//  BookingAppUI
//
//  Created by MacV on 22/11/21.
//

import Foundation

struct BookingModel {
    let storeName: String
    let time: String
    let orderPlaced: String
    let day: String
    static var empty:BookingModel {
           return {
               BookingModel(storeName: "", time: "", orderPlaced: "", day: "")
            }()
    }
}
