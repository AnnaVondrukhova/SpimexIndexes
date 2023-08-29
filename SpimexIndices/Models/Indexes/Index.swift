//
//  Index.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

struct Index: Codable {
    
    let date: String
    let section: SectionName?
    let code: String
    let name: String?
    let nameEng: String
    let typeCode: String?
    let typeName: String?
    let typeNameEng: String?
    let productCode: String?
    let productName: String?
    let productNameEng: String?
    let productTypeName: String?
    let productTypeNameEng: String?
    let placeCode: String?
    let placeName: String?
    let placeNameEng: String?
    let placeTypeName: String?
    let placeTypeNameEng: String?
    
    enum CodingKeys: String, CodingKey{
        case date = "date"
        case section = "section"
        case code = "code"
        case name = "name"
        case nameEng = "name_eng"
        case typeCode = "type_code"
        case typeName = "type_name"
        case typeNameEng = "type_name_eng"
        case productCode = "product_code"
        case productName = "product_name"
        case productNameEng = "product_name_eng"
        case productTypeName = "product_type_name"
        case productTypeNameEng = "product_type_name_eng"
        case placeCode = "place_code"
        case placeName = "place_name"
        case placeNameEng = "place_name_eng"
        case placeTypeName = "place_type_name"
        case placeTypeNameEng = "place_type_name_eng"
    }
}
