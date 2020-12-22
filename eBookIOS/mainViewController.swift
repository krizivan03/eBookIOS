//
//  ViewController.swift
//  eBookIOS
//
//  Created by Christopher Canales on 12/21/20.
//

import UIKit

class mainViewController: UIViewController {
    var USERID:String?
    
    @IBOutlet weak var reccomendTab: UIBarButtonItem!
    @IBOutlet weak var favoritesTab: UIBarButtonItem!
    @IBOutlet weak var libraryTab: UIBarButtonItem!
    
    
    @IBOutlet weak var libraryVC: UIView!
    @IBOutlet weak var getRecVC: UIView!
    @IBOutlet weak var favoritesVC: UIView!
    //    let favoritesVC = favoritesViewController()
//    let getReccomendVC = getReccomendViewController()
//    let bookLibraryVC = bookLibraryViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Displays BookLibrary First
        favoritesVC.isHidden = true;
        getRecVC.isHidden = true;
        
        
        
    }
   
    @IBAction func toReccomentTab(_ sender: UIBarButtonItem) {
        favoritesVC.isHidden = true;
        getRecVC.isHidden = false;
        libraryVC.isHidden = true;
        
    }
    @IBAction func toFavoritesTab(_ sender: UIBarButtonItem) {
        favoritesVC.isHidden = false;
        getRecVC.isHidden = true;
        libraryVC.isHidden = true;
    }
    @IBAction func toLibraryTab(_ sender: UIBarButtonItem) {
        favoritesVC.isHidden = true;
        getRecVC.isHidden = true;
        libraryVC.isHidden = false;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesSegue" {
            let favoritesVC = segue.destination as! favoritesViewController
            favoritesVC.USERID = self.USERID
        }
    }

}

