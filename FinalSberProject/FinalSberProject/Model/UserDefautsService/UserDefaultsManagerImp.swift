//
//  UserDefaultsManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 26.08.2021.
//

import Foundation

class UserDefaultsManagerImp: UserDefautltsManager {
    let defaults = UserDefaults.standard

    func setDataInUserDefaults(pageType: TypeOngoings, key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(pageType) else { return }
        defaults.setValue(data, forKey: "type")
    }

    func readDataOnUserDefaults(key: String) -> TypeOngoings? {
        let jsonDecoder = JSONDecoder()
        guard let data = defaults.data(forKey: key),
              let decodeData = try? jsonDecoder.decode(TypeOngoings.self, from: data)
        else { return nil }
        return decodeData
    }

}
