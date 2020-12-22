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
