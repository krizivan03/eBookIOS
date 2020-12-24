//
//  LogInViewController.swift
//  eBookIOS
//
//  Created by Christopher Canales on 12/21/20.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var USERID:String?
    
    override func viewDidLoad() {
        loadingSpinner.isHidden = true
        super.viewDidLoad()
    }
    @IBAction func logInBtn(_ sender: UIButton) {
        toggleSpinner()
        if let aUSERID = userIDTextField.text {
            if aUSERID == "" {
                toggleSpinner()
                showAlert(theMessage: "Please enter User ID")
                return
            }
            userIDTextField.text = ""
            let theEndPoint = "https://hnm1qlqi1m.execute-api.us-east-1.amazonaws.com/dev/findUser/\(aUSERID)"
            var request = URLRequest(url: URL(string: theEndPoint)!)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Check if Error took place
                if let error = error {
                    self.showAlert(theMessage: "Error took place \(error)")
                    self.toggleSpinner()
                    return
                }
                // Read HTTP Response Status code
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 { // successful
                        self.USERID = aUSERID
                        self.toggleSpinner()
//                        print("SUCCESS: Response HTTP Status code: \(response.statusCode)")
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "toMainViewController", sender: self)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
//                            print("FAIL: Response HTTP Status code: \(response.statusCode)")
                            self.toggleSpinner()
                            self.showAlert(theMessage: "Invalid User ID")
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    @IBAction func createUser(_ sender: UIButton) {
        toggleSpinner()
        var newUSERID:Int?
        let theEndPoint = "https://hnm1qlqi1m.execute-api.us-east-1.amazonaws.com/dev/addUser"
        var request = URLRequest(url: URL(string: theEndPoint)!)
        request.httpMethod = "GET"
        
        let theEndPoint2 = "https://hnm1qlqi1m.execute-api.us-east-1.amazonaws.com/dev/getLastID"
        var request2 = URLRequest(url: URL(string: theEndPoint2)!)
        request2.httpMethod = "GET"
        let task2 = URLSession.shared.dataTask(with: request2) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                self.toggleSpinner()
                self.showAlert(theMessage: "Error took place \(error)")
                return
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 { // successful
                        print("SUCCESS in task 2: Response HTTP Status code: \(response.statusCode)")
                    self.toggleSpinner()
                    let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSMutableArray
                    newUSERID = (jsonResult[0] as! NSDictionary)["max"] as! Int
                            DispatchQueue.main.async {
                                self.USERID = "\(newUSERID!)"
                                self.showAlertandSegue(theMessage: "Success! Your new User ID is \(newUSERID!)")
                            }
                } else {
                    DispatchQueue.main.async {
//                            print("FAIL: Response HTTP Status code: \(response.statusCode)")
                        self.toggleSpinner()
                        self.showAlert(theMessage: "Error creating User")
                    }

                }
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                self.toggleSpinner()
                self.showAlert(theMessage: "Error took place \(error)")
                return
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 { // successful
                        print("SUCCESS in task 1: Response HTTP Status code: \(response.statusCode)")
                    task2.resume()
                } else {
                    DispatchQueue.main.async {
//                            print("FAIL: Response HTTP Status code: \(response.statusCode)")
                        self.toggleSpinner()
                        self.showAlert(theMessage: "Error creating User")
                    }

                }
            }
        }
        task.resume()
    }
    func showAlert(theMessage: String){
        let alert = UIAlertController(title: "", message: theMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertandSegue(theMessage: String){
        let alert = UIAlertController(title: "", message: theMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default){ (action) in
//            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toMainViewController", sender: self)
//            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    func toggleSpinner() {
        DispatchQueue.main.async {
            if (self.loadingSpinner.isHidden){ // if hidden
                self.loadingSpinner.isHidden = false // show
                self.loadingSpinner.startAnimating()
            }else{
                self.loadingSpinner.isHidden = true // else hide
                self.loadingSpinner.stopAnimating()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainViewController" {
            let mainViewController = segue.destination as! mainViewController
            mainViewController.USERID = self.USERID
        }
    }
    

}
