//
//  LoginPageViewController.swift
//  Vescle
//
//  Created by Jonathan Sussman on 2/19/17.
//  Copyright © 2017 Jonathan Sussman. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var username_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //Connect to Database
        let username = username_input.text;
        let password = password_input.text;
        //check for empty fields
        if ((username?.isEmpty)! || (password?.isEmpty)!) {
            //display alert message
            self.display_alert_message(alert: "all fields are required");
            return;
        }
        
        //store data server side
        //sift through response to see what we have to do
        var request = URLRequest(url: URL(string: "http://localhost:3000/userRegister.php")!)
        request.httpMethod = "POST";
        let postString = "username=\(username)&password=\(password)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print ("statusCode should be 200, but is \(httpStatus.statusCode)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("ResponseString= \(responseString)")
            
            //do stuff with response string
            
            
            self.display_alert_message(alert: "registration successful! Thanks for using Vescle!");
            
        }
        task.resume();
        
        //mark as logged in and return to protexted page
        UserDefaults.standard.set(true, forKey: "logged_in");
        UserDefaults.standard.synchronize();
        
        
        
    }
    
    func display_alert_message(alert:String) {
        let my_alert = UIAlertController(title:"Alert", message:alert, preferredStyle: UIAlertControllerStyle.alert);
        
        let ok_action = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        my_alert.addAction(ok_action);
        
        self.present(my_alert, animated: true, completion:nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
