//
//  ViewController.swift
//  Homework 11 (Screen, User Profile)
//
//  Created by Dmitrii Pogonia on 16.12.2025.
//

/*
 Домашнее задание 11. Экран - карточка пользователя.
 
 Цель: Cоздать экран описания пользователя.

 Описание/Пошаговая инструкция выполнения домашнего задания:
 
 Создать экран описания пользователя (в стандартном проекте) - ImageView с картинкой по умолчанию, поле ФИО, кнопка по нажатию которой меняется отображение ФИО - показывать полное - показывать только имя. Для базового варианта - сделать это в том же виде, как мы это делали на лекции, для расширенного - добавить поля: должность, адрес, кнопку копировать адрес в буфер обмена

 Критерии оценки:
 Создание контроллера и расположение элементов на нем - 40 баллов.
 Реализация действия по нажатию кнопки - 20 баллов.
 Добавление дополнительных полей - 20 баллов.
 Добавление действия "скопировать в буфер обмена" - 20 баллов.

 Компетенции:
 Построение пользовательского интерфейса
 - работать со свойствами UIView
 - создавать UIViewController
 - работать со свойствами UIViewController
 
 */

// Добавил для удобства SwiftUI превью, как в лекции говорили

import UIKit

class ViewController: UIViewController {
    
    private var isFullName = true
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect (x: 16, y: 47, width: 358, height: 358))
        imageView.image = UIImage (systemName: "person.fill")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .quaternaryLabel
        imageView.tintColor = .lightGray
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(frame: CGRect (x: 294, y: 325, width: 80, height: 80))
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 413, width: 358, height: 40))
        label.text = "Дмитрий Евгеньевич Погоня"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 461, width: 358, height: 21))
        label.text = "OTUS HOMEWORK 11"
        return label
    }()
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 461, width: 358, height: 21))
        label.text = "Должность: iOS-разработчик"
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 461, width: 358, height: 21))
        label.text = "Адрес: Россия, г. Сочи"
        return label
    }()
    
    private lazy var bufferButton: UIButton = {
        let button: UIButton = UIButton(frame: CGRect(x: 16, y: 760, width: 358, height: 50))
        button.backgroundColor = .systemGray4
        button.setTitle("Копировать адрес в буфер обмена", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didTapBufferButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameButton: UIButton = {
        let button: UIButton = UIButton(frame: CGRect(x: 16, y: 760, width: 358, height: 50))
        button.backgroundColor = .systemGray4
        button.setTitle("Формат имени", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didTapNameButton), for: .touchUpInside)
        //nameButton.addTarget(self, action: #selector(didTapNameButton), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(descriptionLabel)
        view.addSubview(nameLabel)
        view.addSubview(occupationLabel)
        view.addSubview(addressLabel)
        view.addSubview(bufferButton)
        view.addSubview(nameButton)
        
        // Доп сделал как на лекции смену заголовка вверху
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let model = ViewModel(name: "OTUS")
            self.setupViewModel(model)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            let model = ViewModel(name: "Swift Basics")
            self.setupViewModel(model)
        }
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false  // ← добавь
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        bufferButton.translatesAutoresizingMaskIntoConstraints = false
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: 358),
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            occupationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            occupationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            occupationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            occupationLabel.heightAnchor.constraint(equalToConstant: 20),

            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addressLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 4),
            addressLabel.heightAnchor.constraint(equalToConstant: 20),
            
            cameraButton.widthAnchor.constraint(equalToConstant: 80),
            cameraButton.heightAnchor.constraint(equalToConstant: 80),
            cameraButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -16),
            cameraButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -16),
            
            nameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nameButton.heightAnchor.constraint(equalToConstant: 40),
            
            bufferButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bufferButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bufferButton.bottomAnchor.constraint(equalTo: nameButton.topAnchor, constant: -8),
            bufferButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func setupViewModel(_ model: ViewModel) {
        descriptionLabel.text = model.name }
    
    
    private func selectImageAction(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = sourceType
            pickerController.allowsEditing = true
            present (pickerController, animated: true)
        }
    }
    
    // Взял с лекции для практики
    @objc private func didTapCameraButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose image", message: nil, preferredStyle:
                .actionSheet)
        let firstAction = UIAlertAction(title: "Choose from gallery", style: .default) { [self] _ in
            selectImageAction(sourceType: .photoLibrary)
        }
        let secondAction = UIAlertAction(title: "Choose photo", style: .default) { [self] _ in
            selectImageAction(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func didTapNameButton(_ sender: UIButton) {
        isFullName.toggle()
        
        if isFullName {
            nameLabel.text = "Дмитрий Евгеньевич Погоня"
            sender.setTitle("Сокращённое имя", for: .normal)
        } else {
            nameLabel.text = "Дмитрий Погоня"
            sender.setTitle("Полное ФИО", for: .normal)
        }
    }
    
    @objc private func didTapBufferButton(_ sender: UIButton) {
        // Копируем текст из addressLabel в буфер обмена - не понял, нужно ли это было делать или просто кнопку реализовать
        UIPasteboard.general.string = addressLabel.text
        
        sender.setTitle("✓ Скопировано!", for: .normal)
        
        // Дополнительно реализовал
        // Через 1 секунду возвращаем исходный текст
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender.setTitle("Копировать адрес в буфер обмена", for: .normal)
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ViewController()
        }
    }
}
#endif




