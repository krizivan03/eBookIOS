//
//  booksTableViewCell.swift
//  eBookIOS
//
//  Created by Christopher Canales on 12/22/20.
//

import UIKit

class booksTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var theBookView: UIView!
    
    var bookID:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let bookView = theBookView, let bIMG = bookImage {
            bookView.layer.cornerRadius = 10
            bIMG.frame = CGRect(x: 10, y: 10, width: 100, height: 150)
            bIMG.contentMode = . scaleAspectFill
            bIMG.layer.cornerRadius = 10
            bIMG.clipsToBounds = true
            
        }
        
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
        
}
extension UIButton{
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 1.0
        pulse.toValue =  0.7
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.0
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
    
}
    

