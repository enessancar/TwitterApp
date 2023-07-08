//
//  ProfileTextField.swift
//  TwitterApp
//
//  Created by Enes Sancar on 7.07.2023.
//

import UIKit

final class ProfileTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String) {
        self.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    private func configure() {
        keyboardType = .default
        backgroundColor = .secondarySystemFill
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}

