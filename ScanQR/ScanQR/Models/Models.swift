//
//  Models.swift
//  ScanQR
//
//  Created by MacV on 05/01/22.
//

import Foundation
import UIKit

struct LastScanModel {
    let barcode: String
    let time: String
   
    static var empty:LastScanModel {
           return {
               LastScanModel(barcode: "", time: "")
            }()
    }
}
