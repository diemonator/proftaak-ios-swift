//
//  MasterViewController.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    // hardcoded printers
    var printers = [Printer(name: "Printer A", priterColorState: UIColor.gray, status: "IDEAL", image: UIImage(named: "printerA")!),Printer(name: "Printer B", priterColorState: UIColor.green, status: "ACTIVE", image: UIImage(named: "printerB")!),Printer(name: "Printer C", priterColorState: UIColor.red, status: "IDEAL", image: UIImage(named: "printerC")!)]

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MasterViewController.timerPrinter), userInfo: nil, repeats: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        printers.insert(Printer(name: "New Printer", priterColorState: UIColor.gray, status: "IDEAL", image: UIImage(named: "horizontalLine")!), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Sending printer to Detailed view
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let printer = printers[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.printer = printer
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
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
        cell.printerStateLabel.text = printer.printerStatus
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            printers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // Timer decreases the values of the printers properties
    @objc func timerPrinter() {
        // Cyan Ink
        printers[0].inkCyan -= 1
        printers[1].inkCyan -= 2
        printers[2].inkCyan -= 3
        // Magenta
        printers[0].inkMagenta -= 3
        printers[1].inkMagenta -= 2
        printers[2].inkMagenta -= 1
        // Key
        printers[0].inkKey -= 2
        printers[1].inkKey -= 1
        printers[2].inkKey -= 3
        // Yellow
        printers[0].inkYellow -= 4
        printers[1].inkYellow -= 3
        printers[2].inkYellow -= 2
        // paper
        printers[0].paper -= 1
        printers[1].paper -= 1
        printers[2].paper -= 1
        // oil
        printers[0].oil -= 1
        printers[1].oil -= 2
        printers[2].oil -= 3
    }
}

