//
//  ViewController.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnNext(_ sender: Any) {
        let testimonialsVC: TestimonialsViewController = TestimonialsViewController.instantiate(appStoryboard: .testimonials)
        navigationController?.pushViewController(testimonialsVC, animated: true)
    }
    
}

