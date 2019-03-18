//
//  InventoryEndpoint.swift
//  BirdBits
//
//  Created by Jared Wheeler on 3/5/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import Foundation

protocol InventoryEndpointConsumer: class {
    func update(with newInventoryData: [String: [PartModel]])
}

struct InventoryEndpoint {
    static func loadAllInventory(for requester: InventoryEndpointConsumer) {
        var components = URLComponents()
        components.scheme = APIConstants.urlScheme
        components.host = APIConstants.host
        components.path = APIConstants.environmentPath + "/v1/inventory"
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let dataTask = NetworkService.shared.dataTask(with: request) { (data, response, error) in
            guard let code = (response as? HTTPURLResponse)?.statusCode, NetworkService.successRange ~= code else {
                //            let error = (data != nil) ? NetworkService.responseError(from: data!) : error ?? NetworkError.unknownError
                //Blow up, an error occurred
                //            print(error)
                return
            }

            guard let data = data else { return }

            do {
                let responseModel = try JSONDecoder().decode([PartModel].self, from: data)
                let nestedResponseModel = Dictionary(grouping: responseModel, by: {$0.type})
                DispatchQueue.main.async {
                    requester.update(with: nestedResponseModel)
                }
            } catch {
                return
            }
        }
        dataTask.resume()
    }
}
