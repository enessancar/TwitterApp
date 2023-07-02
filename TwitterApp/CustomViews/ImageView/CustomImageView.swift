//
//  CustomImageView.swift
//  TwitterApp
//
//  Created by Enes Sancar on 30.06.2023.
//

import UIKit

final class CustomImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(cornerRadius: CGFloat, contentMode: UIView.ContentMode) {
        self.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }
    
    convenience init(cornerRadius: CGFloat) {
        self.init(frame: .zero) 
        self.contentMode = contentMode
    }
    
    private func configure() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
    }
}
