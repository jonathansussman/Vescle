//
//  ViewController.swift
//  Vescle
//
//  Created by Jonathan Sussman on 2/19/17.
//  Copyright © 2017 Jonathan Sussman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*
        let logged_in = UserDefaults.standard.bool(forKey: "logged_in");
        
        if (!logged_in) {
            self.performSegue(withIdentifier: "toLogin", sender: self);
        }
        */
        self.performSegue(withIdentifier: "toLogin", sender: self);
        
    }
    /*
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "logged_in");
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "toLogin", sender: self)
        
    }
    */
}

