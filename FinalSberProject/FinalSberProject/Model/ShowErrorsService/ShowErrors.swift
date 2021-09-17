//
//  ShowErrors.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 17.09.2021.
//

import Foundation
import UIKit

final class ShowErrors {
    static func showErrorMessage(message: String, on showVc: UIViewController) {
        DispatchQueue.main.async { [weak showVc] in
            let warningAlert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            showVc?.present(warningAlert, animated: true, completion: nil)
        }
    }
}
