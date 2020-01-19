//
//  Request.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST
}

struct Request {
    static func post(url: Endpoint, httpMethod: HTTPMethod, parameters: [String: Any], completion: @escaping (_ json: [String: Any]?, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: url.url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {
                completion(nil, error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                completion(nil, "statusCode should be 2xx, but is \(response.statusCode) for \(response)")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completion(json, nil)
                }
            } catch let error {
                completion(nil, "Error with JSON deserialization: \(error.localizedDescription)")
            }
            
        }
        .resume()
    }
}
