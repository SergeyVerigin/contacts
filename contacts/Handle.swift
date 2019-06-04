//
//  Handle.swift
//  contacts
//
//  Created by Веригин С.И. on 28/05/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import UIKit

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   @objc func  SelectProfileImageview() {
    let picker = UIImagePickerController()
    
    picker.delegate = self
    picker.allowsEditing = true
    present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedPhotoUser: UIImage?
        
        if let editImage = info [UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedPhotoUser = editImage
        }
       else if let originalImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {

       selectedPhotoUser = originalImage
        }
        if let selectedImage = selectedPhotoUser {
          DispatchQueue.main.async {
           self.imageView.image = selectedImage
            if self.imageView.image == nil  {
                self.uploadImage.isHidden = false
            } else {
                self.uploadImage.isHidden = true
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

