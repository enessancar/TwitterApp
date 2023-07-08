//
//  ProfileDataFormVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 7.07.2023.
//

import UIKit
import PhotosUI
import SnapKit

final class ProfileDataFormVC: UIViewController {
    
    //MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    private lazy var hintLabel = CustomLabel(text: Constants.Profile.hint
        .rawValue, textColor: .label, fontSize: 32, weight: .bold)
    
    private let displayNameTextField = ProfileTextField(name: "Display name")
    private let usernameTextField = ProfileTextField(name: "Username")
    private let avatarPlaceHolderImageView = CustomImage(cornerRadius: 60, backgroundColor: .lightGray, tintColor: .gray)
    
    private let bioTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemFill
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = Constants.Profile.bio.rawValue
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    private let sumbitButton = CustomButton(title: Constants.Profile.sumbit.rawValue, tintColor: .white, backgroundColor: Colors.twitterBlue, fontSize: 16, weight: .bold, cornerRadius: 25)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }
}

extension ProfileDataFormVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
        isModalInPresentation = true
         
        view.addSubviews(scrollView)
        scrollView.addSubviews(hintLabel, avatarPlaceHolderImageView,displayNameTextField, usernameTextField, bioTextView, sumbitButton)
        
        bioTextView.delegate = self
        displayNameTextField.delegate = self
        usernameTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        avatarPlaceHolderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload)))
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        avatarPlaceHolderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
            make.top.equalTo(hintLabel.snp.bottom).offset(30)
        }
        
        displayNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(avatarPlaceHolderImageView.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(displayNameTextField)
            make.top.equalTo(displayNameTextField.snp.bottom).offset(20)
        }
        
        bioTextView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(displayNameTextField)
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.height.equalTo(150)
        }
        
        sumbitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
        }
    }
}

//MARK: - TextField Delegate
extension ProfileDataFormVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

//MARK: - TextView Delegate
extension ProfileDataFormVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.Profile.bio.rawValue
            textView.textColor = .gray
        }
    }
}

//MARK: - Objc Func
extension ProfileDataFormVC {
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1 ;
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileDataFormVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self else { return }
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.avatarPlaceHolderImageView.image = image
                    }
                }
            }
        }
    }
}
