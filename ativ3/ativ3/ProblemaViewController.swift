//
//  ProblemaViewController.swift
//  ativ3
//
//  Created by Edivaldo Serafim on 05/09/21.
//  Copyright © 2021 Edivaldo Serafim. All rights reserved.
//

import UIKit

class ProblemaViewController: UIViewController {
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    var problema: Problema?
    @IBOutlet weak var labelCategory: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textViewSymary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let problemaFormViewController = segue.destination as? ProblemaFormViewController{
            problemaFormViewController.problema = problema
        }
    }
    
    func prepareScreen(){
        if let problema = problema{
            if let image = problema.image{
                imageViewPoster.image = UIImage(data: image)
            }
            labelTitle.text = problema.title
            labelRating.text = problema.done
            labelCategory.text = problema.categories
            labelDuration.text = problema.address
            textViewSymary.text = problema.descrip
        }
    }

    
}

