//
//  CustomButton.swift
//  TwitterApp
//
//  Created by Enes Sancar on 5.07.2023.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    convenience init(title: String, tintColor: UIColor ,backgroundColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: weight)
        self.layer.cornerRadius = cornerRadius
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
}
