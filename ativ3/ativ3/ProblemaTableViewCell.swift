//
//  ProblemaTableViewCell.swift
//  ativ3
//
//  Created by Edivaldo Serafim on 07/09/21.
//  Copyright © 2021 Edivaldo Serafim. All rights reserved.
//

import UIKit

class ProblemaTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPoster: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDone: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configWith(_ problema: Problema){
        labelTitle.text = problema.title
        labelAddress.text = problema.descrip
        labelDone.text = problema.done
        if let image = problema.image{
            imageViewPoster.image = UIImage(data: image)
        }
        
    }

}
