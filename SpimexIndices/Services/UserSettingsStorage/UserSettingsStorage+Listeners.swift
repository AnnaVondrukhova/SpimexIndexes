//
//  UserSettingsStorage+Listeners.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 30.03.2023.
//

import Foundation

protocol UserListener {
    func didUpdateUser(user: User)
}

extension UserSettingsStorage {
    func addListener(_ listener: UserListener) {
        listeners.append(listener)
    }
}
