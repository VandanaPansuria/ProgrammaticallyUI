//
//  OrderModel.swift
//  DesignOfPages
//
//  Created by MacV on 24/12/21.
//

import Foundation
struct OrderModel {
    let tableName: String
    let orderPlaced: String
    let time: String
    let status: String
    let payment: String
    let items: String
    static var empty:OrderModel {
           return {
               OrderModel(tableName: "", orderPlaced: "", time: "", status: "", payment: "",items: "")
            }()
    }
}
struct newOrderModel {
    let tableName: String
    let newOrderPlaced: String
    let time: String
    let numberofpeoples: String
    static var empty:newOrderModel {
           return {
               newOrderModel(tableName: "", newOrderPlaced: "", time: "",numberofpeoples: "")
            }()
    }
}
class MenuOrder {
    var orderMenuName: String?
    var orderSubMenuName:  [SubMenuOrder]?
    
    init(orderMenuName: String, orderSubMenuName: [SubMenuOrder]) {
        self.orderMenuName = orderMenuName
        self.orderSubMenuName = orderSubMenuName
    }
}
class SubMenuOrder{
    var menuName: String?
    var menuValue: [String]?
    init(menuName: String , menuValue : [String]) {
        self.menuName = menuName
        self.menuValue = menuValue
    }
}
struct ProductOrder {
    let menuName: String?
    let menuValue: [String]?
    var increseDescrese : [String]?
    var incDec : [String]?
    static var empty:ProductOrder {
           return {
               ProductOrder(menuName: "", menuValue: [""],increseDescrese:[""],incDec:[""])
            }()
    }
}
struct OrderOverView {
    let menuName: String?
    let menuValue: [String]?
    var qtyValue : String?
    static var empty:OrderOverView {
        return {
            OrderOverView(menuName: "", menuValue: [""],qtyValue : "")
        }()
    }
}
struct OrderView {
    let menuName: String?
    let menuValue: [String]?
    var qtyValue : String?
    static var empty:OrderView {
        return {
            OrderView(menuName: "", menuValue: [""],qtyValue : "")
        }()
    }
}
struct CheckOutOrderView {
    let menuName: String?
    let qty: String?
    let price: String?
    static var empty:CheckOutOrderView {
        return {
            CheckOutOrderView(menuName: "",qty: "", price: "")
        }()
    }
}
