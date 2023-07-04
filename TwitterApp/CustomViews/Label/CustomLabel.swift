//
//  CustomLabel.swift
//  TwitterApp
//
//  Created by Enes Sancar on 28.06.2023.
//

import UIKit

final class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
    }
    
    convenience init(textColor: UIColor, numberOfLines: Int) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
    
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textAlignment = textAlignment
    }
    
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        numberOfLines = 0
    }
}
