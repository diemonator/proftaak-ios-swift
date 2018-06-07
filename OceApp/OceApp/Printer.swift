//
//  Printer.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class Printer: NSObject {
    // Private fields
    private var voil = 100
    private var vpaper = 100
    private var vcyan = 100
    private var vmagenta = 100
    private var vyellow = 100
    private var vkey = 100
    // Public fields
    var printerImage: UIImage
    var printerName: String
    var printerGeneralState: UIColor
    var printerStatus: String
    // Properties Ints
    var inkCyan: Int {
        get { return vcyan }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue >= 0) { vcyan = aNewValue; stringCyan = String(vcyan) + " %" + " RESET" }
            else if (aNewValue >= 0) { vcyan = aNewValue; stringCyan = String(vcyan)+" %" }
        }
    }
    var inkYellow: Int {
        get { return vyellow }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue >= 0) { vyellow = aNewValue; stringYellow = String(vyellow) + " %" + " RESET" }
            else if (aNewValue >= 0) { vyellow = aNewValue; stringYellow = String(vyellow)+" %" }
        }
    }
    var inkKey: Int {
        get { return vkey }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue >= 0) { vkey = aNewValue; stringKey = String(vkey) + " %" + " RESET" }
            else if (aNewValue >= 0) { vkey = aNewValue; stringKey = String(vkey)+" %" }
        }
    }
    var inkMagenta: Int {
        get { return vmagenta }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue >= 0) { vmagenta = aNewValue; stringMagenta = String(vmagenta) + " %" + " RESET" }
            else if (aNewValue >= 0) { vmagenta = aNewValue; stringMagenta = String(vmagenta)+" %" }
        }
    }
    var paper: Int {
        get { return vpaper }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue >= 0) { vpaper = aNewValue; stringPaper = String(vpaper) + " %" + " RESET" }
            else if (aNewValue >= 0) { vpaper = aNewValue; stringPaper = String(vpaper)+" %" }
        }
    }
    var oil: Int {
        get { return voil }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue >= 0) { voil = aNewValue; stringOil = String(voil) + " %" + " RESET" }
            else if (aNewValue >= 0) { voil = aNewValue; stringOil = String(voil)+" %" }
        }
    }
    // Properties Ints to String
    var stringCyan: String!
    var stringYellow: String!
    var stringKey: String!
    var stringMagenta: String!
    var stringOil: String!
    var stringPaper: String!
    // Constructor
    init(name: String, priterColorState: UIColor, status: String, image: UIImage) {
        self.printerName = name
        self.printerGeneralState = priterColorState
        self.printerStatus = status
        self.printerImage = image
    }
}

