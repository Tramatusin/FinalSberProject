//
//  UserDefautlsProtocol.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 26.08.2021.
//

import Foundation

protocol UserDefautltsManager {
    func setDataInUserDefaults(pageType: TypeOngoings, key: String)

    func readDataOnUserDefaults(key: String) -> TypeOngoings?
}
