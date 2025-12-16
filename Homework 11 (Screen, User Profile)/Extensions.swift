//
//  Extensions.swift
//  Homework 11 (Screen, User Profile)
//
//  Created by Dmitrii Pogonia on 16.12.2025.
//

import UIKit

extension ViewController {
    struct ViewModel {
        let name: String
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                              didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.editedImage] as? UIImage
        profileImageView.image = selectedImage
        dismiss(animated: true)
    }
}

