//
//  EventHandler.swift
//  OceApp
//
//  Created by Emil Karamihov on 07/06/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

protocol EventHandlerDelegate : NSObjectProtocol {
    func changeState(sender: Printer)
    func startTimer(sender: Printer)
}
