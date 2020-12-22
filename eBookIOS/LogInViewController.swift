//
//  LogInViewController.swift
//  eBookIOS
//
//  Created by Christopher Canales on 12/21/20.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var userIDTextField: UITextField!
    
    var USERID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func logInBtn(_ sender: UIButton) {
        if let aUSERID = userIDTextField.text {
            if aUSERID == "" {
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
                    return
                }
                // Read HTTP Response Status code
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 { // successful
                        self.USERID = aUSERID
                        print("SUCCESS: Response HTTP Status code: \(response.statusCode)")
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "toMainViewController", sender: self)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            print("FAIL: Response HTTP Status code: \(response.statusCode)")
                            self.showAlert(theMessage: "Invalid User ID")
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    func showAlert(theMessage: String){
        let alert = UIAlertController(title: "", message: theMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainViewController" {
            let mainViewController = segue.destination as! mainViewController
            mainViewController.USERID = self.USERID
        }
    }
    

}
