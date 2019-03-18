//
//  PartValuesModel.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/26/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import Foundation

struct PartValuesModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case displayValue
        case displayUnit
        case normalizedValue
    }
    
    let displayValue: Double
    let normalizedValue: Double
    let displayUnit: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayValue = try container.decode(Double.self, forKey: .displayValue)
        normalizedValue = try container.decode(Double.self, forKey: .normalizedValue)
        displayUnit = try container.decode(String.self, forKey: .displayUnit)
    }
    
}
