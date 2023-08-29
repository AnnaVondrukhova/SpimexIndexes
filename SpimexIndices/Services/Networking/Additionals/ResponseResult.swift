//
//  ResponseResult.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

enum ResponseResult<T> {
    case success(ResponseData<T>)
    case failure(_ error: String)
}

struct ResponseData<T> {
    var body: T
}
