//
//  Alert+Ext.swift
//  TwitterApp
//
//  Created by Enes Sancar on 7.07.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title : String, alertMessage : String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
