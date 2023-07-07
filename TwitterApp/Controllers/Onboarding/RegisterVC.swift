//
//  RegisterVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 4.07.2023.
//

import UIKit
import SnapKit
import Combine

final class RegisterVC: UIViewController {
    
    private var viewModel = AuthenticationViewViewModel()
    private var subscription: Set<AnyCancellable> = []
    
    //MARK: - Properties
    private lazy var registerTitleLabel = CustomLabel(text: Constants.Register.registerTitle.rawValue, textColor: .label, fontSize: 32, weight: .bold)
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: Constants.Register.email.rawValue,attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: Constants.Register.password.rawValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Register.createAccount.rawValue, for: .normal)
        button.tintColor = .white
        button.backgroundColor = Colors.twitterBlue
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        
        viewModel.$isAuthenticationFormValid.sink { [weak self] validationState in
            guard let self else { return }
            self.registerButton.isEnabled = validationState
        }
        .store(in: &subscription)
        viewModel.$user.sink { [weak self] user in
            guard let self else { return }
            guard user != nil else { return }
            
            guard let vc = self.navigationController?.viewControllers.first as? OnboardingVC else {
                return
            }
            vc.dismiss(animated: true)
        }
        .store(in: &subscription)
        
        viewModel.$error.sink { [weak self] errorString in
            guard let self, let error = errorString else { return }
            self.showAlert(title: "Error", alertMessage: error)
        }
        .store(in: &subscription)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
        bindViews()
    }
}

extension RegisterVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(registerTitleLabel, emailTextField, passwordTextField, registerButton)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        registerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(registerTitleLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.height.width.centerX.equalTo(emailTextField)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
    }
}

//MARK: - Objc Func
extension RegisterVC {
    @objc private func didChangeEmailField() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc private func didChangePasswordField() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc private func didTapRegister() {
        viewModel.createUser()
    }
}
