//
//  IndexesEndPoint.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

enum IndexesEndPoint {
    case indexes
    case indexCurrent(section: SectionName, code: String)
    case indexHistory(request: IndexRequest, period: IndexPeriod)
    case indexSections
    case sectionIndexesCurrent(section: SectionName)
}

extension IndexesEndPoint: EndPointType {
    var baseURL: URL {
        return baseServiceURL
    }
    
    var path: String {
        switch self {
        case .indexes:
            return IndexesAPIPath.indexes.path
        case .indexCurrent(let section, let code):
            var params : [String : Any] = [:]
            params["section"] = section.rawValue
            params["index"] = code
            return IndexesAPIPath.indexCurrent.path.pathEncode(with: params)
        case .indexHistory(let request, _):
            var params : [String : Any] = [:]
            params["section"] = request.section
            params["index"] = request.indexCode
            return IndexesAPIPath.indexHistory.path.pathEncode(with: params)
        case .indexSections:
            return IndexesAPIPath.indexSections.path
        case .sectionIndexesCurrent(let section):
            var params : [String : Any] = [:]
            params["section"] = section.rawValue
            return IndexesAPIPath.sectionIndexesCurrent.path.pathEncode(with: params)
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .indexes:
            return .request
        case .indexCurrent:
            return .request
        case .indexHistory(let request, _):
            var params : [String : Any] = [:]
            params["dateFrom"] = request.dateFrom
            params["dateTo"] = request.dateTo
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params)
        case .indexSections:
            return .request
        case .sectionIndexesCurrent:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}

extension IndexesEndPoint {
    var fakeResponseData: Data? {
        switch self {
        case .indexes:
            do {
                if let bundlePath = Bundle.main.path(forResource: "IndexesAll", ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            return nil
        case .sectionIndexesCurrent:
            do {
                if let bundlePath = Bundle.main.path(forResource: "petroleum_etip_current", ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            return nil
        case .indexHistory(_, let period):
            do {
                var fileName = ""
                switch period {
                case .week:
                    fileName = "history_week"
                case .month:
                    fileName = "history_month"
                default:
                    fileName = "history_all"
                }
                if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            return nil
        default:
            return nil
        }
    }
}
