//
//  Printer.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class Printer: NSObject {
    
    private var voil = 100
    private var vpaper = 100
    private var vcyan = 100
    private var vmagenta = 100
    private var vyellow = 100
    private var vkey = 100

    var printerImage: UIImage!
    var printerName: String!
    var printerGeneralState: UIColor 
    var printerStatus: String

    var inkCyan: Int {
        get { return vcyan }
        set (aNewValue) { if (aNewValue >= 0) { vcyan = aNewValue } }
    }
    var inkYellow: Int {
        get { return vyellow }
        set (aNewValue) { if (aNewValue >= 0) { vyellow = aNewValue } }
    }
    var inkKey: Int {
        get { return vkey }
        set (aNewValue) { if (aNewValue >= 0) { vkey = aNewValue } }
    }
    var inkMagenta: Int {
        get { return vmagenta }
        set (aNewValue) { if (aNewValue >= 0) { vmagenta = aNewValue } }
    }
    var paper: Int {
        get { return vpaper }
        set (aNewValue) { if (aNewValue >= 0) { vpaper = aNewValue } }
    }
    var oil: Int {
            get { return voil }
            set (aNewValue) { if (aNewValue >= 0) { voil = aNewValue } }
    }
    
    init(name: String, priterColorState: UIColor, status: String, image: UIImage) {
        self.printerName = name
        self.printerGeneralState = priterColorState
        self.printerStatus = status
        self.printerImage = image
    }
}

