//
//  RegisterPageViewController.swift
//  Vescle
//
//  Created by Jonathan Sussman on 2/19/17.
//  Copyright © 2017 Jonathan Sussman. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    //inputted variables
    @IBOutlet weak var name_input: UITextField!
    @IBOutlet weak var username_input: UITextField!
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    @IBOutlet weak var password2_input: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerbutton(_ sender: Any) {
        let name = name_input.text;
        let username = username_input.text;
        let email = email_input.text;
        let password = password_input.text;
        let password2 = password2_input.text;
        
        //check for empty fields
        if ((name?.isEmpty)! || (username?.isEmpty)! || (email?.isEmpty)! ||
            (password?.isEmpty)! || (password2?.isEmpty)!) {
            
            //display alert message
            display_alert_message(alert: "all fields are required");
            return;
        }
        
        //limit number of characters for each field
        if ((name?.characters.count)! > 20 || (username?.characters.count)! > 20 || (email?.characters.count)! > 20) {
            display_alert_message(alert: "fields cannot be longer than 20 character")
            return;
        }
        
        //warn about only using letters, numbers and underscores (cleanse all data with regex)
        //check email
        if (!isValidEmail(testStr: email!)) {
            display_alert_message(alert: "must enter valid email");
            return;
        }
        //check name
        if (!isValidName(testStr: name!)) {
            display_alert_message(alert: "name can only contain letters and spaces");
            return;
        }
        //check username
        if (!isValidUsername(testStr: username!)) {
            display_alert_message(alert: "username can only contain letters,numbers and underscores");
            return;
        }
        //check password
        if (!isValidPassword(testStr: password!)) {
            display_alert_message(alert: "password contains illegal characters");
            return;
        }
        
        //check if passwords matched
        if (password != password2) {
            display_alert_message(alert: "passwords do not match");
            return;
        }
        
        //store data server side
        //sift through response to see what we have to do
        var request = URLRequest(url: URL(string: "http://localhost:3000/userRegister.php")!)
        request.httpMethod = "POST";
        let postString = "name=\(name)&username=\(username)&email=\(email)&password=\(password)";
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
        
    }
    
    func display_alert_message(alert:String) {
        let my_alert = UIAlertController(title:"Alert", message:alert, preferredStyle: UIAlertControllerStyle.alert);
        
        let ok_action = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        my_alert.addAction(ok_action);
        
        self.present(my_alert, animated: true, completion:nil);
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidUsername(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let usernameRegEx = "[A-Z0-9a-z._]"
        let usernametest = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return usernametest.evaluate(with: testStr)
    }
    func isValidName(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let nameRegEx = "[A-Za-z ]"
        let nametest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nametest.evaluate(with: testStr)
    }
    func isValidPassword(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let passwordRegEx = "[A-Za-z_0-9!@#$%^&*()-_]"
        let passwordtest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordtest.evaluate(with: testStr)
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
