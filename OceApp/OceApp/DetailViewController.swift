//
//  DetailViewController.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // delegate
    weak var delegate: EventHandlerDelegate?
    
    @IBOutlet var lCyan: UILabel!
    @IBOutlet var lYellow: UILabel!
    @IBOutlet var lMagenta: UILabel!
    @IBOutlet var lOil: UILabel!
    @IBOutlet var lPaper: UILabel!
    @IBOutlet var lKey: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!

    var timer: Timer?
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = printer {
            if let imgView = imageView {
                // setting printer details on views
                imgView.image = detail.printerImage
                self.navigationItem.title = detail.printerName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        var tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapPaper))
        lPaper.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapOil))
        lOil.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapCyan))
        lCyan.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapKey))
        lKey.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapYellow))
        lYellow.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapMagenta))
        lMagenta.addGestureRecognizer(tap)
        
        setLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var printer: Printer? {
        didSet {
            // Update the view.
            configureView()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DetailViewController.updateLabels), userInfo: nil, repeats: true)
        }
    }
 
    @objc func updateLabels(sender:UITapGestureRecognizer) {
        setLabels()
        if (printer?.printerStatus == PrinterStatus.IDLE) {
            timer!.invalidate()
            setLabels()
        }
    }
    
    @objc func tapPaper(sender:UITapGestureRecognizer) {
        printer!.paper = 100
        checkAll()
    }
    
    @objc func tapOil(sender:UITapGestureRecognizer) {
        printer!.oil = 100
        checkAll()
    }
    
    @objc func tapCyan(sender:UITapGestureRecognizer) {
        printer!.inkCyan = 100
        checkAll()
    }
    
    @objc func tapYellow(sender:UITapGestureRecognizer) {
        printer!.inkYellow = 100
        checkAll()
    }
    
    @objc func tapKey(sender:UITapGestureRecognizer) {
        printer!.inkKey = 100
        checkAll()
    }
    
    @objc func tapMagenta(sender:UITapGestureRecognizer) {
        printer!.inkMagenta = 100
        checkAll()
    }
    
    private func checkAll() {
        if (printer!.paper > 0 && printer!.oil > 0 && printer!.inkCyan > 0 && printer!.inkYellow > 0 && printer!.inkKey > 0 && printer!.inkMagenta > 0) {
            printer!.printerGeneralState = UIColor.green
            printer!.printerStatus = PrinterStatus.ACTIVE
            checkTimerValidity()
            delegate?.startTimer(sender: printer!)
        } else {
            setLabels()
        }
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        printer!.printerGeneralState = UIColor.green
        printer!.printerStatus = PrinterStatus.ACTIVE
        printer!.inkCyan = 100
        printer!.inkKey = 100
        printer!.inkMagenta = 100
        printer!.inkYellow = 100
        printer!.paper = 100
        printer!.oil = 100
        checkTimerValidity()
        delegate?.startTimer(sender: printer!)
    }
    
    private func checkTimerValidity() {
        if (timer?.isValid == false) {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DetailViewController.updateLabels), userInfo: nil, repeats: true)
        }
    }
    
    private func setLabels() {
        if (printer != nil) {
            lCyan.text = printer?.stringCyan
            lKey.text = printer?.stringKey
            lOil.text = printer?.stringOil
            lPaper.text = printer?.stringPaper
            lYellow.text = printer?.stringYellow
            lMagenta.text = printer?.stringMagenta
        }
    }
}
