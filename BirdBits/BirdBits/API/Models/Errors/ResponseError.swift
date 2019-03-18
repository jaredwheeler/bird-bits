//
//  ResponseError.swift
//  BirdBits
//
//  Created by Jared Wheeler on 3/5/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import Foundation

enum ResponseErrorType {
    case invalidInput(types: [InputError])
    case defaultError
}

extension ResponseErrorType: RawRepresentable {
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "InvalidInput":
            self = .invalidInput(types: [])
        default:
            self = .defaultError
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .invalidInput(types: _):
            return "InvalidInput"
        default:
            return "default_error"
        }
    }
    
}

struct ResponseError: Decodable, Error {
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case model = "error"
        case errors = "errors"
    }
    
    static var testJSON: String {
        return """
        {
        "error": {
        "code": "InvalidInput",
        "message": "Please check the input",
        "errors": [
        {
        "code": "InvalidFirstName",
        "message": "Invalid first name, please update."
        }
        ]
        }
        }
        """
    }
    
    static var testData: Data? {
        return ResponseError.testJSON.data(using: .utf8)
    }
    
    private var code: String
    
    var message: String
    var errorType: ResponseErrorType
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let error = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .model)
        
        code = try error.decode(String.self, forKey: .code)
        message = try error.decode(String.self, forKey: .message)
        
        switch code {
        case ResponseErrorType.invalidInput(types: []).rawValue:
            let errors = try error.decode([InputError].self, forKey: .errors)
            errorType = .invalidInput(types: errors)
        default:
            errorType = .defaultError
        }
    }
    
    init(_ inputErrors: [InputError]) {
        let errorType = ResponseErrorType.invalidInput(types: inputErrors)
        self.errorType = errorType
        self.code = errorType.rawValue
        self.message = "Please check the input"
    }
    
}
