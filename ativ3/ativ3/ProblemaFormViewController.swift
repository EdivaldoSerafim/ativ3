//
//  ProblemaFormViewController.swift
//  ativ3
//
//  Created by Edivaldo Serafim on 07/09/21.
//  Copyright © 2021 Edivaldo Serafim. All rights reserved.
//

import UIKit

class ProblemaFormViewController: UIViewController {

    
    @IBOutlet weak var textViewDescricao: UITextView!
    @IBOutlet weak var imageViewProblema: UIImageView!
    @IBOutlet weak var textFieldCategories: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldDone: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    
    var problema: Problema?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let problema = problema{
            title = "Editar"
            textFieldTitle.text = problema.title
            textFieldDone.text = problema.done
            textFieldAddress.text = problema.address
            textViewDescricao.text = problema.descrip
            textFieldCategories.text = problema.categories
            if let image = problema.image{
                imageViewProblema.image = UIImage(data: image)
            }
        }
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        print("foi")
        let alert = UIAlertController(title: "Selecionar foto", message: "Selecione uma foto para o problema", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
                self.selectPicture(sourceTyle: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca", style: .default) { (_) in
            self.selectPicture(sourceTyle: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Álbum", style: .default) { (_) in
            self.selectPicture(sourceTyle: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelar)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceTyle: UIImagePickerController.SourceType){
        let imagePiker = UIImagePickerController()
        imagePiker.sourceType = sourceTyle
        imagePiker.delegate = self
        present(imagePiker, animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        if problema == nil{
            problema = Problema(context: context)
        }
        
        problema?.title = textFieldTitle.text
        problema?.descrip = textViewDescricao.text
        problema?.address = textFieldAddress.text
        problema?.categories = textFieldCategories.text
        problema?.done = textFieldDone.text
        problema?.image = imageViewProblema.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProblemaFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            imageViewProblema.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
