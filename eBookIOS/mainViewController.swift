//
//  ViewController.swift
//  eBookIOS
//
//  Created by Christopher Canales on 12/21/20.
//

import UIKit



class mainViewController: UIViewController{
    var USERID:String?
    
    @IBOutlet weak var reccomendTab: UIBarButtonItem!
    @IBOutlet weak var favoritesTab: UIBarButtonItem!
    @IBOutlet weak var libraryTab: UIBarButtonItem!
    
    
    @IBOutlet weak var libraryVC: UIView!
    @IBOutlet weak var getRecVC: UIView!
    @IBOutlet weak var favoritesVC: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesVC.isHidden = true;
        getRecVC.isHidden = true;
        
        favoritesTab.tintColor = .white
        libraryTab.tintColor = .systemTeal
        reccomendTab.tintColor = .white
        
    }
   
    @IBAction func toReccomentTab(_ sender: UIBarButtonItem) {
        favoritesVC.isHidden = true;
        getRecVC.isHidden = false;
        libraryVC.isHidden = true;
        
        favoritesTab.tintColor = .white
        libraryTab.tintColor = .white
        reccomendTab.tintColor = .green
        
    }
    @IBAction func toFavoritesTab(_ sender: UIBarButtonItem) {
        favoritesVC.isHidden = false;
        getRecVC.isHidden = true;
        libraryVC.isHidden = true;
        
        favoritesTab.tintColor = .red
        libraryTab.tintColor = .white
        reccomendTab.tintColor = .white
        
    }
    @IBAction func toLibraryTab(_ sender: UIBarButtonItem) {
        favoritesVC.isHidden = true;
        getRecVC.isHidden = true;
        libraryVC.isHidden = false;
        
        favoritesTab.tintColor = .white
        libraryTab.tintColor = .systemTeal
        reccomendTab.tintColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesSegue" {
            let favoritesVC = segue.destination as! favoritesViewController
            favoritesVC.USERID = self.USERID
        }
        if segue.identifier == "bookLibrarySegue" {
            let bookLibraryVC = segue.destination as! bookLibraryViewController
            bookLibraryVC.USERID = self.USERID
        }
        if segue.identifier == "getReccomendSegue" {
            let getRecVC = segue.destination as! getReccomendViewController
            getRecVC.USERID = self.USERID
        }
    }
    

}

