//
//  MasterViewController.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, EventHandlerDelegate {
    // fields
    private var detailViewController: DetailViewController? = nil
    // hardcoded printers
    private var printers = [Printer(name: "Printer A", image: UIImage(named: "printerA")!),Printer(name: "Printer B", image: UIImage(named: "printerB")!),Printer(name: "Printer C", image: UIImage(named: "printerC")!)]
    // Separete Timer for every printer
    private var timer1: Timer?
//    private var timer2: Timer?
//    private var timer3: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        // Subscribe printers to event
        for printer in printers {
            printer.delegate = self
        }
        // Initiate timers
        if (timer1 == nil /*&& timer2 == nil && timer3 == nil*/) {
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter1), userInfo: nil, repeats: true)
//            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter2), userInfo: nil, repeats: true)
//            timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter3), userInfo: nil, repeats: true)
        }
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func insertNewObject(_ sender: Any) {
        for printer in printers {
            printer.inkCyan = 100
            printer.inkKey = 100
            printer.inkYellow = 100
            printer.inkMagenta = 100
            printer.oil = 100
            printer.paper = 100
            printer.printerStatus = PrinterStatus.ACTIVE
            printer.printerGeneralState = UIColor.green
            // changeState(sender: printer)
            startTimer(sender: printer)
        }
        tableView.reloadData()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Sending printer to Detailed view
        if (segue.identifier == "showDetail") {
            if let indexPath = tableView.indexPathForSelectedRow {
                let printer = printers[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.printer = printer
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.delegate = self
            } else {
                let printer = printers[0]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.printer = printer
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.delegate = self
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Using CustomTableCell class to get items from it
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableCell
        // Setting printer
        let printer = printers[indexPath.row]
        // Setting labels and imageView with background color also making it round
        cell.printerNameLabel.text = printer.printerName
        cell.printerStateLabel.text = printer.printerStatus.rawValue
        cell.printerStatusImgView.layer.borderWidth = 1.5
        cell.printerStatusImgView.layer.masksToBounds = false
        cell.printerStatusImgView.layer.borderColor = UIColor.black.cgColor
        cell.printerStatusImgView.layer.cornerRadius = cell.printerStatusImgView.frame.size.width / 2
        cell.printerStatusImgView.clipsToBounds = true
        cell.printerStatusImgView.backgroundColor = printer.printerGeneralState
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Random from 0 to 3
    private func generateRandom() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    // Timer decreases the values of the printer's properties
    @objc func timerPrinter1() {
        printers[0].inkCyan -= generateRandom()
        printers[0].inkKey -= generateRandom()
        printers[0].inkYellow -= generateRandom()
        printers[0].inkMagenta -= generateRandom()
        printers[0].paper -= generateRandom()
        printers[0].oil -= generateRandom()
    }
    
//    @objc func timerPrinter2() {
//        printers[1].inkCyan -= generateRandom()
//        printers[1].inkKey -= generateRandom()
//        printers[1].inkYellow -= generateRandom()
//        printers[1].inkMagenta -= generateRandom()
//        printers[1].paper -= generateRandom()
//        printers[1].oil -= generateRandom()
//    }
//    
//    @objc func timerPrinter3() {
//        printers[2].inkCyan -= generateRandom()
//        printers[2].inkKey -= generateRandom()
//        printers[2].inkYellow -= generateRandom()
//        printers[2].inkMagenta -= generateRandom()
//        printers[2].paper -= generateRandom()
//        printers[2].oil -= generateRandom()
//    }
    
    // Protocol methods
    func startTimer(sender: Printer) {
        if (sender.printerName == "Printer A")  {
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter1), userInfo: nil, repeats: true)
        }
//            else if (sender.printerName == "Printer B") {
//            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter2), userInfo: nil, repeats: true)
//        } else if (sender.printerName == "Printer C") {
//            timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter3), userInfo: nil, repeats: true)
//        }
        tableView.reloadData()
    }
    
    func changeState(sender: Printer) {
        if (sender.printerName == "Printer A")  {
            timer1?.invalidate()
        }
//        else if (sender.printerName == "Printer B") {
//            timer2?.invalidate()
//        } else if (sender.printerName == "Printer C") {
//            timer3?.invalidate()
//        }
        tableView.reloadData()
    }
}

