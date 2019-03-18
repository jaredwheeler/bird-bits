//
//  InputError.swift
//  BirdBits
//
//  Created by Jared Wheeler on 3/5/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import Foundation

struct InputError: Decodable, Error {
    
    enum ErrorType: String {
        
        case firstName = "InvalidFirstName"
        case lastName = "InvalidLastName"
        case email = "InvalidEmailAddress"
        case phoneNumber = "InvalidPhoneNumber"
        case zipCode = "InvalidZipCode"
        case verificationCode = "InvalidSMSCode"
    }
    
    private var code: String
    
    var message: String
    
    init(_ code: String, message: String) {
        self.code = code
        self.message = message
    }
    
    init(_ errorType: ErrorType, message: String? = nil)  {
        self.code = errorType.rawValue
        self.message = message ?? ""
    }
    
}
