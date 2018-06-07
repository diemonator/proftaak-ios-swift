//
//  DetailViewController.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var printer: Printer? {
        didSet {
            // Update the view.
            configureView()
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(DetailViewController.updateLabels), userInfo: nil, repeats: true)
            }
        }
    }
 
    @objc func updateLabels(sender:UITapGestureRecognizer) {
        lCyan.text = printer?.stringCyan
        lKey.text = printer?.stringKey
        lOil.text = printer?.stringOil
        lPaper.text = printer?.stringPaper
        lYellow.text = printer?.stringYellow
        lMagenta.text = printer?.stringMagenta
    }
    
    @objc func tapPaper(sender:UITapGestureRecognizer) {
        printer!.paper = 100
    }
    
    @objc func tapOil(sender:UITapGestureRecognizer) {
        printer!.oil = 100
    }
    
    @objc func tapCyan(sender:UITapGestureRecognizer) {
        printer!.inkCyan = 100
    }
    
    @objc func tapYellow(sender:UITapGestureRecognizer) {
        printer!.inkYellow = 100
    }
    
    @objc func tapKey(sender:UITapGestureRecognizer) {
        printer!.inkKey = 100
    }
    
    @objc func tapMagenta(sender:UITapGestureRecognizer) {
        printer!.inkMagenta = 100
    }
}
