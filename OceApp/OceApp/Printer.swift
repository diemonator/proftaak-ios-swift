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
    private var _oil = 100
    private var _paper = 100
    private var _cyan = 100
    private var _magenta = 100
    private var _yellow = 100
    private var _key = 100
    // Public fields
    var printerImage: UIImage
    var printerName: String
    var printerGeneralState: UIColor
    var printerStatus: PrinterStatus
    // Properties Ints
    var inkCyan: Int {
        get { return _cyan }
        set (value) {
            if (value <= 25 && value > 0) { _cyan = value; stringCyan = "Cyan Ink: " + String(_cyan) + "% RESET" }
            else if (value > 0) { _cyan = value; stringCyan = "Cyan Ink: " + String(_cyan) + " %" }
            else if (value <= 0) { _cyan = 0; stringCyan = "Cyan Ink: " + String(_cyan) + " % RESET"; criticalState() }
        }
    }
    var inkYellow: Int {
        get { return _yellow }
        set (value) {
            if (value <= 25 && value > 0) { _yellow = value; stringYellow = "Yellow Ink: " + String(_yellow) + " % RESET" }
            else if (value > 0) { _yellow = value; stringYellow = "Yellow Ink: " + String(_yellow) + " %" }
            else if (value <= 0) { _yellow = 0; stringYellow = "Yellow Ink: " + String(_yellow) + " % RESET"; criticalState() }
        }
    }
    var inkKey: Int {
        get { return _key }
        set (value) {
            if (value <= 25 && value > 0) { _key = value; stringKey = "Key Ink: " + String(_key) + " % RESET" }
            else if (value > 0) { _key = value; stringKey = "Key Ink: " + String(_key) + " %" }
            else if (value <= 0) { _key = 0; stringKey = "Key Ink: " + String(_key) + " % RESET"; criticalState() }
        }
    }
    var inkMagenta: Int {
        get { return _magenta }
        set (value) {
            if (value <= 25 && value > 0) { _magenta = value; stringMagenta = "Magenta Ink: " + String(_magenta) + " % RESET" }
            else if (value > 0) { _magenta = value; stringMagenta = "Magenta Ink: " + String(_magenta) + " %" }
            else if (value <= 0) { _magenta = 0; stringMagenta = "Magenta Ink: " + String(_magenta) + " % RESET"; criticalState() }
        }
    }
    var paper: Int {
        get { return _paper }
        set (value) {
            if (value <= 25 && value > 0) { _paper = value; stringPaper = "Paper: " + String(_paper) + " % RESET" }
            else if (value > 0) { _paper = value; stringPaper = "Paper: " + String(_paper) + " %" }
            else if (value <= 0) { _paper = 0; stringPaper = "Paper: " + String(_paper) + " % RESET"; criticalState() }
        }
    }
    var oil: Int {
        get { return _oil }
        set (value) {
            if (value <= 25 && value > 0) { _oil = value; stringOil = "Oil: " + String(_oil) + " % RESET"}
            else if (value > 0) { _oil = value; stringOil = "Oil: " + String(_oil) + " %" }
            else if (value <= 0) { _oil = 0; stringOil = "Oil: " + String(_oil) + " % RESET"; criticalState() }
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

