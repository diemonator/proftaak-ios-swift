//
//  Printer.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class Printer: NSObject {
    var printerName: String!
    var printerGeneralState: UIColor
    var printerStatus: String
    
    init(name: String, priterColorState: UIColor, status: String) {
        self.printerName = name
        self.printerGeneralState = priterColorState;
        self.printerStatus = status;
    }
}
