//
//  Alert.swift
//  TestRoutFinder
//
//  Created by Дмитрий Скоробогаты on 14.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertAdress(titile: String, placeholder: String, complitionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: titile, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let textField = alert.textFields?.first
            guard let text = textField?.text else { return }
            complitionHandler(text)
        }
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        alert.addAction(alertOk)
        alert.addAction(alertCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func alerterror(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOk)
        present(alert, animated: true, completion: nil)
        
    }
}
