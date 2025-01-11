//
//  Classes.swift
//  UItest
//
//  Created by MacV on 9/24/21.
//

import Foundation
struct Health {
    let itemname:String?
    let name:String?
    let datetime:String?
    let about:String?
}
class GroceriesAPI {
    static func getData() -> [Health]{
        let contacts = [
            Health(itemname: "Maysoon", name: "Mohammad Hussain", datetime: "9:00am-13:00am", about: "about description"),
            Health(itemname: "Macdonalds", name: "Tamilarasi Mohan", datetime: "8:00am-13:00am", about: "about description mohan")
        ]
        return contacts
    }
}
class HealthAPI {
    static func getData() -> [Health]{
        let contacts = [
            Health(itemname: "Heath wellness1", name: "Mohammad Hussain1", datetime: "9:00am-13:00am", about: "about description heath"),
            Health(itemname: "Heath wellness2", name: "Tamilarasi Mohan2", datetime: "8:00am-13:00am", about: "about description mohan heath"),
            Health(itemname: "Heath wellness3", name: "Mohammad Hussain3", datetime: "9:00am-13:00am", about: "about description heath")
        ]
        return contacts
    }
}
class AppointmentAPI {
    static func getData() -> [Health]{
        let contacts = [
            Health(itemname: "Appointment1", name: "Hussain 1", datetime: "9:00am-13:00am", about: "about description app"),
            Health(itemname: "Appointment2", name: "Tamilarasi 2", datetime: "8:00am-13:00am", about: "about description mohan app")
        ]
        return contacts
    }
}
