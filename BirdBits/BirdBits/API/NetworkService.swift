//
//  NetworkService.swift
//  BirdBits
//
//  Created by Jared Wheeler on 3/5/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import UIKit

enum Result {
    case success(data: Data?)
    case failure(error: Error)
}

enum NetworkError: Error {
    case invalidRequest
    case unexpectedResponse
    case unknownError
}

class NetworkService {
    
    static let successRange = 200..<300
    
    static var shared: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 300
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = true
        }
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()
}
