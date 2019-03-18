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
        case stock
        case caseCode
        case type
    }
    let id: String
    let partNumber: String
    let manufacturer: String
    let stock: Int
    let caseCode: String
    let type: String
    let partValues: PartValuesModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        partNumber = try container.decode(String.self, forKey: .partNumber)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        stock = try container.decode(Int.self, forKey: .stock)
        caseCode = try container.decode(String.self, forKey: .caseCode)
        type = try container.decode(String.self, forKey: .type)
        
        partValues = try container.decode(PartValuesModel.self, forKey: .partValues)
    }
    
}
