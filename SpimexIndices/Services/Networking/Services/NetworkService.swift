//
//  NetworkService.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import Foundation

enum NetworkResponse: String {
    case success
    case noConnection = "Please check your network connection."
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

class NetworkService<T:Codable> {
    
    func request<EndPoint: EndPointType>(endPoint: EndPoint, completion: @escaping ((ResponseResult<T>) -> ())) {
        
        let router = Router<EndPoint>()
        
        if let fakeResponseData = endPoint.fakeResponseData {
            
            print("❗️FAKE❗️" + endPoint.path)
            print(fakeResponseData)
           
            if let jsonData = try? JSONSerialization.jsonObject(with: fakeResponseData, options: .mutableContainers) {
                print("❗️FAKE❗️")
//                print(jsonData)
            }
            
            JSONDeserializer().decode(data: fakeResponseData) { (result: T?) in
                if let result = result {
                    let responseResultData = ResponseData<T>(body: result)
                    completion(.success(responseResultData))
                } else {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }
            }
        } else {
            router.request(endPoint) { data, response, error in
                
                if error != nil {
                    completion(.failure(NetworkResponse.noConnection.rawValue))
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(NetworkResponse.noData.rawValue))
                            return
                        }
                        
                        print(responseData)
                        
                        if let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) {
                            print(jsonData)
                        }
                        
                        JSONDeserializer().decode(data: responseData) { (result: T?) in
                            if let result = result {
                                let responseResultData = ResponseData<T>(body: result)
                                completion(.success(responseResultData))
                            } else {
                                completion(.failure(NetworkResponse.unableToDecode.rawValue))
                            }
                        }
                    case .failure(let networkFailureError):
                        completion(.failure(networkFailureError))
                    }
                }
            }
        }
        
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
            switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
            case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
            case 600: return .failure(NetworkResponse.outdated.rawValue)
            default: return .failure(NetworkResponse.failed.rawValue)
            }
        }
}

