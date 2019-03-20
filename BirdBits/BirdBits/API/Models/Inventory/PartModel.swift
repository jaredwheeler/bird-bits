//
//  PartModel.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/26/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import Foundation

struct PartModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case partNumber
        case manufacturer
        case partValues
        case count
        case caseCode
        case type
    }
    let partNumber: String
    let manufacturer: String
    let count: Int
    let caseCode: String
    let type: String
    let partValues: PartValuesModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        partNumber = try container.decode(String.self, forKey: .id)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        count = try container.decode(Int.self, forKey: .count)
        caseCode = try container.decode(String.self, forKey: .caseCode)
        type = try container.decode(String.self, forKey: .type)
        
        partValues = try container.decode(PartValuesModel.self, forKey: .partValues)
    }
    
}
