//
//  IndexesStorageManager.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 15.03.2023.
//

import Foundation

class IndexesStorageManager {
    static let shared = IndexesStorageManager()
    
    private var indexesStorageFileName = "AllIndexesNames"
    private lazy var indexRequestManager: IndexRequestManager = {
        return IndexRequestManager()
    }()
    
    var listeners: [IndexListener] = []
    
    var allIndexes: [Index] = []
    
    func updateIndexes() {
        do {
            let indexesData: [Index]? = try? JSONFileManager.loadJSON(withFilename: indexesStorageFileName)
            if let indexesData = indexesData, !indexesData.isEmpty {
                let needsUpdate = checkNeedsUpdate(indexesData)
                if needsUpdate {
                    loadIndexes()
                } else {
                    self.allIndexes = indexesData
                    listeners.forEach { listener in
                        listener.didUpdateIndexes()
                    }
                }
            } else {
                loadIndexes()
            }
        }
    }
    
    private func checkNeedsUpdate(_ indexes: [Index]) -> Bool {
        guard let dateString = indexes.first?.date else {
            loadIndexes()
            return true
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let updateDate = formatter.date(from: dateString)?.addingTimeInterval(60 * 60 * 9) else {
            return true
        }
        
        let newUpdateDate = updateDate.addingTimeInterval(60 * 60 * 24)
        return Date() >= newUpdateDate
    }
    
    private func loadIndexes() {
        indexRequestManager.getIndexNames { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let indexes = data.body else { return }
                
                self.allIndexes = indexes
//                JSONFileManager.testSave(indexes: indexes, toFilename: self.indexesStorageFileName)
                
                do {
                    if try JSONFileManager.saveJSON(jsonObject: indexes, toFilename: self.indexesStorageFileName) {
                        self.listeners.forEach { listener in
                            listener.didUpdateIndexes()
                        }
                    }
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
