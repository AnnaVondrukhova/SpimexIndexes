//
//  IndexesStorageManager+Listeners.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 15.03.2023.
//

import Foundation

protocol IndexListener {
    func didUpdateIndexes()
}

extension IndexesStorageManager {
    func addListener(_ listener: IndexListener) {
        listeners.append(listener)
    }
}
