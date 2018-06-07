//
//  Printer.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class Printer: NSObject {
    // delegate
    weak var delegate: EventHandlerDelegate?
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
    var printerStatus: PrinterStatus
    // Properties Ints
    var inkCyan: Int {
        get { return vcyan }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue > 0) { vcyan = aNewValue; stringCyan = "Cyan Ink: " + String(vcyan) + "% RESET" }
            else if (aNewValue > 0) { vcyan = aNewValue; stringCyan = "Cyan Ink: " + String(vcyan) + " %" }
            else if (aNewValue == 0) { vcyan = aNewValue; stringCyan = "Cyan Ink: " + String(vcyan) + " % RESET"; criticalState() }
        }
    }
    var inkYellow: Int {
        get { return vyellow }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue > 0) { vyellow = aNewValue; stringYellow = "Yellow Ink: " + String(vyellow) + " % RESET" }
            else if (aNewValue > 0) { vyellow = aNewValue; stringYellow = "Yellow Ink: " + String(vyellow)+" %" }
            else if (aNewValue == 0) { vyellow = aNewValue; stringYellow = "Yellow Ink: " + String(vyellow) + " % RESET"; criticalState() }
        }
    }
    var inkKey: Int {
        get { return vkey }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue > 0) { vkey = aNewValue; stringKey = "Key Ink: " + String(vkey) + " % RESET" }
            else if (aNewValue > 0) { vkey = aNewValue; stringKey = "Key Ink: " + String(vkey)+" %" }
            else if (aNewValue == 0) { vkey = aNewValue;stringKey = "Key Ink: " + String(vkey) + " % RESET"; criticalState() }
        }
    }
    var inkMagenta: Int {
        get { return vmagenta }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue > 0) { vmagenta = aNewValue; stringMagenta = "Magenta Ink: " + String(vmagenta) + " % RESET" }
            else if (aNewValue > 0) { vmagenta = aNewValue; stringMagenta = "Magenta Ink: " + String(vmagenta)+" %" }
            else if (aNewValue == 0) { vmagenta = aNewValue; stringMagenta = "Magenta Ink: " + String(vmagenta) + " % RESET"; criticalState() }
        }
    }
    var paper: Int {
        get { return vpaper }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue > 0) { vpaper = aNewValue; stringPaper = "Paper: " + String(vpaper) + " % RESET" }
            else if (aNewValue > 0) { vpaper = aNewValue; stringPaper = "Paper: " + String(vpaper)+" %" }
            else if (aNewValue == 0) { vpaper = aNewValue; stringPaper = "Paper: " + String(vpaper) + " % RESET"; criticalState() }
        }
    }
    var oil: Int {
        get { return voil }
        set (aNewValue) {
            if (aNewValue <= 25 && aNewValue > 0) { voil = aNewValue; stringOil = "Oil: " + String(voil) + " % RESET"}
            else if (aNewValue > 0) { voil = aNewValue; stringOil = "Oil: " + String(voil)+" %" }
            else if (aNewValue == 0) { voil = aNewValue; stringOil = "Oil: " + String(voil) + " % RESET"; criticalState() }
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
    init(name: String, image: UIImage) {
        self.printerName = name
        self.printerGeneralState = UIColor.green
        self.printerStatus = PrinterStatus.ACTIVE
        self.printerImage = image
    }
    
    private func criticalState() {
        printerGeneralState = UIColor.red
        printerStatus = PrinterStatus.IDLE
        delegate?.changeState(sender: self)
    }
    
}

