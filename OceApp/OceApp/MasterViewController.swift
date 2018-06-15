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
    private var timer2: Timer?
    private var timer3: Timer?
    private var checkedCyan = false
    private var checkedMageta = false
    
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
        if (timer1 == nil && timer2 == nil && timer3 == nil) {
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter1), userInfo: nil, repeats: true)
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter2), userInfo: nil, repeats: true)
            timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter3), userInfo: nil, repeats: true)
        }
        self.performSegue(withIdentifier: "showDetail", sender: self)
        turnOffLights()
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
            changeState(sender: printer)
            startTimer(sender: printer)
        }
        turnOffLights()
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
        // 249
        fadeLamp(number: printers[0].paper, lampNr: 1)
        if (!checkedCyan) {
            if (printers[0].inkCyan <= 25) {
                CyanLamp()
                checkedCyan = true
            }
        }
        if (!checkedMageta) {
            if (printers[0].inkMagenta <= 25) {
                MagentaLamp()
                checkedMageta = true
            }
        }
    }
    
    private func fadeLamp(number: Int, lampNr: Int)
    {
        var UrlRequest = URLRequest(url: URL(string: "http:192.168.0.100/api/N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI/lights/\(lampNr)/state")!)
        
        UrlRequest.httpMethod = "PUT"
        UrlRequest.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        UrlRequest.setValue("N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI", forHTTPHeaderField: "Authorization Bearer ")
        
        let jsonDictonary = NSMutableDictionary()
        jsonDictonary.setValue(true, forKey: "on")
        jsonDictonary.setValue(254, forKey: "sat")
        jsonDictonary.setValue(200, forKey: "bri")
        jsonDictonary.setValue(number*251, forKey: "hue")
        
        let jsonData:Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDictonary, options: JSONSerialization.WritingOptions())
            UrlRequest.httpBody = jsonData
        } catch {
            print("Error in jsonnnn")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: UrlRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    private func CyanLamp()
    {
        var UrlRequest = URLRequest(url: URL(string: "http:192.168.0.100/api/N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI/lights/4/state")!)
        
        UrlRequest.httpMethod = "PUT"
        UrlRequest.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        UrlRequest.setValue("N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI", forHTTPHeaderField: "Authorization Bearer ")
        
        let jsonDictonary = NSMutableDictionary()
        jsonDictonary.setValue(true, forKey: "on")
        jsonDictonary.setValue(254, forKey: "sat")
        jsonDictonary.setValue(200, forKey: "bri")
        jsonDictonary.setValue(41000, forKey: "hue")
        
        let jsonData:Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDictonary, options: JSONSerialization.WritingOptions())
            UrlRequest.httpBody = jsonData
        } catch {
            print("Error in jsonnnn")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: UrlRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    private func MagentaLamp()
    {
        var UrlRequest = URLRequest(url: URL(string: "http:192.168.0.100/api/N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI/lights/3/state")!)
        
        UrlRequest.httpMethod = "PUT"
        UrlRequest.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        UrlRequest.setValue("N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI", forHTTPHeaderField: "Authorization Bearer ")
        
        let jsonDictonary = NSMutableDictionary()
        jsonDictonary.setValue(true, forKey: "on")
        jsonDictonary.setValue(254, forKey: "sat")
        jsonDictonary.setValue(200, forKey: "bri")
        jsonDictonary.setValue(59000, forKey: "hue")
        
        let jsonData:Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDictonary, options: JSONSerialization.WritingOptions())
            UrlRequest.httpBody = jsonData
        } catch {
            print("Error in jsonnnn")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: UrlRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    private func turnOffLights() {
        for i in 1...5 {
            var UrlRequest = URLRequest(url: URL(string: "http:192.168.0.100/api/N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI/lights/\(i)/state")!)
            
            UrlRequest.httpMethod = "PUT"
            UrlRequest.setValue("application/Json", forHTTPHeaderField: "Content-Type")
            UrlRequest.setValue("N5ez1VNBfUIY5lcWpRUv6B60hxSbe-UYrrTeYoeI", forHTTPHeaderField: "Authorization Bearer ")
            
            let jsonDictonary = NSMutableDictionary()
            jsonDictonary.setValue(false, forKey: "on")
            
            let jsonData:Data
            do {
                jsonData = try JSONSerialization.data(withJSONObject: jsonDictonary, options: JSONSerialization.WritingOptions())
                UrlRequest.httpBody = jsonData
            } catch {
                print("Error in jsonnnn")
                return
            }
            let session = URLSession.shared
            session.dataTask(with: UrlRequest) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
                }.resume()
        }
        
    }
    
    @objc func timerPrinter2() {
        printers[1].inkCyan -= generateRandom()
        printers[1].inkKey -= generateRandom()
        printers[1].inkYellow -= generateRandom()
        printers[1].inkMagenta -= generateRandom()
        printers[1].paper -= generateRandom()
        printers[1].oil -= generateRandom()
    }
    
    @objc func timerPrinter3() {
        printers[2].inkCyan -= generateRandom()
        printers[2].inkKey -= generateRandom()
        printers[2].inkYellow -= generateRandom()
        printers[2].inkMagenta -= generateRandom()
        printers[2].paper -= generateRandom()
        printers[2].oil -= generateRandom()
    }
    
    // Protocol methods
    func startTimer(sender: Printer) {
        if (sender.printerName == "Printer A")  {
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter1), userInfo: nil, repeats: true)
            turnOffLights()
        }
        else if (sender.printerName == "Printer B") {
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter2), userInfo: nil, repeats: true)
        } else if (sender.printerName == "Printer C") {
            timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MasterViewController.timerPrinter3), userInfo: nil, repeats: true)
        }
        tableView.reloadData()
    }
    
    func changeState(sender: Printer) {
        if (sender.printerName == "Printer A")  {
            timer1?.invalidate()
        }
        else if (sender.printerName == "Printer B") {
            timer2?.invalidate()
        } else if (sender.printerName == "Printer C") {
            timer3?.invalidate()
        }
        tableView.reloadData()
    }
    
}

