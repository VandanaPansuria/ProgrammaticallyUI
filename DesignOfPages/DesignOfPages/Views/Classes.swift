//
//  Classes.swift
//  DesignOfPages
//
//  Created by MacV on 24/12/21.
//

import Foundation
import UIKit
class TableAPI {
    static func getData() -> [OrderModel]{
        let contacts = [
            OrderModel(tableName: "Table 1", orderPlaced: "22:15 pm", time: "22 mins", status: "Not yet prepared", payment: "PAID", items: "12 items"),
            OrderModel(tableName: "Table 2", orderPlaced: "10:15 pm", time: "30 mins", status: "Preparing", payment: "NOT PAID", items: "14 items"),
        ]
        return contacts
    }
}
class AllTableOrderAPI {
    static func getData() -> [OrderModel]{
        let contacts = [
            OrderModel(tableName: "Table 1", orderPlaced: "22:15 pm", time: "22 mins", status: "Not yet prepared", payment: "PAID", items: "12 items"),
            OrderModel(tableName: "Table 2", orderPlaced: "10:15 pm", time: "30 mins", status: "Preparing", payment: "NOT PAID", items: "14 items"),
            OrderModel(tableName: "Online Order", orderPlaced: "09:10 pm", time: "4 hrs", status: "prepared", payment: "PAID", items: "2 items")
        ]
        return contacts
    }
}
class OnlineAPI {
    static func getData() -> [OrderModel]{
        let contacts = [
            OrderModel(tableName: "Online Order", orderPlaced: "09:10 pm", time: "4 hrs", status: "prepared", payment: "PAID", items: "2 items")
        ]
        return contacts
    }
}
