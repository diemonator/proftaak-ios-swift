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
 
    @objc func updateLabels() {
        let char = " %"
        lCyan.text = String(printer!.inkCyan) + char
        lKey.text = String(printer!.inkKey) + char
        lOil.text = String(printer!.oil) + char
        lPaper.text = String(printer!.paper) + char
        lYellow.text = String(printer!.inkYellow) + char
        lMagenta.text = String(printer!.inkMagenta) + char
    }
}
