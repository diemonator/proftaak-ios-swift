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
    var printerImage: UIImage?
    var inkCyan: Int
    var inkYellow: Int
    var inkKey: Int
    var inkMagenta: Int
    var paper: Int
    var oil: Int
    
    init(name: String, priterColorState: UIColor, status: String, image: UIImage) {
        self.printerName = name
        self.printerGeneralState = priterColorState
        self.printerStatus = status
        inkKey = 100
        inkCyan = 100
        inkYellow = 100
        inkMagenta = 100
        paper = 100
        oil = 100
        printerImage = image
    }
}

