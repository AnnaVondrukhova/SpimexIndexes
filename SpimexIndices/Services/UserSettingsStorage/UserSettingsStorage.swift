//
//  UserSettingsStorage.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 16.03.2023.
//

import Foundation

class UserSettingsStorage {
    static let shared = UserSettingsStorage()
    
    private var userSettingsStorageFileName = "UserSettings"
    
    var listeners: [UserListener] = []
    
    var user: User? {
        get {
            if let user: User = try? JSONFileManager.loadJSON(withFilename: userSettingsStorageFileName) {
                return user
            } else {
                return createUser()
            }
        }
    }
    
    func saveUser(user: User, completion: ((Bool) -> Void)? = nil) {
//        let dataString = user.toJsonString()
        
        do {
            listeners.forEach { listener in
                listener.didUpdateUser(user: user)
            }
            try JSONFileManager.saveJSON(jsonObject: user, toFilename: self.userSettingsStorageFileName, completion: completion)
        } catch let error {
            print(error)
        }
    }
    
    func createUser() -> User {
        let group1 = Group(groupId: UUID().uuidString, groupName: "Нефтепродукты", section: .petroleum, products: ["ETIP_DAL_DTL", "ETIP_DAL_DTZ", "ETIP_DAL_REG"])
        let group2 = Group(groupId: UUID().uuidString, groupName: "Нефтепродукты", section: .petroleum, products: ["ETIP_DAL_DTL", "ETIP_DAL_DTZ", "ETIP_DAL_REG"])
        let sheet1 = Sheet(sheetId: UUID().uuidString, sheetName: "Моя подборка", groups: [group1, group2])
        let user = User(sheets: [sheet1], selectedSheetId: sheet1.sheetId)
        
        saveUser(user: user)
        
        return user
    }
}
