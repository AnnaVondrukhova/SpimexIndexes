//
//  IndexRequestManager.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

struct IndexRequestManager {
    
    func getIndexNames(completion: @escaping ((ResponseResult<[Index]?>) -> ())) {
        NetworkService<[Index]?>().request(endPoint: IndexesEndPoint.indexes) { result in
            completion(result)
        }
    }
    
    func getSectionIndexes(section: SectionName, completion: @escaping ((ResponseResult<[IndexInfo]?>) -> ())) {
        NetworkService<[IndexInfo]?>().request(endPoint: IndexesEndPoint.sectionIndexesCurrent(section: section)) { result in
            completion(result)
        }
    }
    
    func getIndexHistory(request: IndexRequest, period: IndexPeriod, completion: @escaping ((ResponseResult<IndexHistoryResponse?>) -> ())) {
        NetworkService<IndexHistoryResponse?>().request(endPoint: IndexesEndPoint.indexHistory(request: request, period: period)) { result in
            completion(result)
        }
    }
}
