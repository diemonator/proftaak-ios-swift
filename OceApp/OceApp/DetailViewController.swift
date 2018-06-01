//
//  DetailViewController.swift
//  OceApp
//
//  Created by Emil Karamihov on 31/05/2018.
//  Copyright © 2018 Fontys University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelCyan: UILabel!
    @IBOutlet weak var labelYellow: UILabel!
    @IBOutlet weak var labelMagenta: UILabel!
    @IBOutlet weak var labelKey: UILabel!
    
    @IBOutlet weak var labelOil: UILabel!
    @IBOutlet weak var labelPaper: UILabel!
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
        if let label = labelCyan {
            label.text = String(printer!.inkCyan) + char
        }
        if let label = labelKey {
            label.text = String(printer!.inkKey) + char
        }
        if let label = labelOil {
            label.text = String(printer!.oil) + char
        }
        if let label = labelPaper {
            label.text = String(printer!.paper) + char
        }
        if let label = labelYellow {
            label.text = String(printer!.inkYellow) + char
        }
        if let label = labelMagenta {
            label.text = String(printer!.inkMagenta) + char
        }
    }
}
