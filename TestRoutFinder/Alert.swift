//
//  Alert.swift
//  TestRoutFinder
//
//  Created by Дмитрий Скоробогаты on 14.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertAdress(titile: String, placeholder: String, complitionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: titile, message: "", preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) {_ in
            let textField = alertController.textFields?.first
            guard let text = textField?.text else { return }
            complitionHandler(text)
        }
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        present(alertController, animated: true, completion: nil)
    }
}
