//
//  NetworkManager.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

enum Format {
    static let jsonType = "application/json"
}

enum HTTPHeader {
    static let headerContentType = "Content-Type"
    static let headerAccept = "Accept"
}

enum HTTPMethod: String, CustomStringConvertible {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    var description: String {
        return self.rawValue
    }
}

enum NetworkErrorCase: Error {
    case invalidURL
    case notFound
}

protocol NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws
}

struct NetworkManager: NetworkManagable {
<<<<<<< HEAD
    enum EndPoints {
        static let cardLists = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/mock/login"
        static let selectedCardList = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080//mock/section"
    }
    
    func getResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
=======
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
>>>>>>> dev
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        guard let url = URL(string: urlString) else {
            throw NetworkErrorCase.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        request.httpBody = body
        if let format = format, let headers = headers {
            headers.forEach {
                request.addValue(format, forHTTPHeaderField: $0)
            }
        }
        
        URLSession.shared.dataTask(with: request) {
            (data, repsonse, error) in
            resultHandler(data, error)
        }.resume()
    }
}

struct MockColumnsSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successColumnsResponseStub, nil)
    }
}

struct MockCardDeleteSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successDeleteResponseStub, nil)
    }
}

struct MockCardCreateSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successCreateResponseStub, nil)
    }
}

struct MockCardEditSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successEditingResponseStub, nil)
    }
}
