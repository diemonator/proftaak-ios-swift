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
            if let label = labelCyan {
                label.text = String(detail.inkCyan)
            }
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
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DetailViewController.updateLabels), userInfo: nil, repeats: true)
            }
        }
    }
 
    @objc func updateLabels() {
        if let label = labelCyan {
            label.text = String(printer!.inkCyan)
        }
        if let label = labelKey {
            label.text = String(printer!.inkKey)
        }
        if let label = labelOil {
            label.text = String(printer!.oil)
        }
        if let label = labelPaper {
            label.text = String(printer!.paper)
        }
        if let label = labelYellow {
            label.text = String(printer!.inkYellow)
        }
        if let label = labelMagenta {
            label.text = String(printer!.inkMagenta)
        }
        
    }
    
}
