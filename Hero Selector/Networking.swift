//
//  Networking.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import Foundation

protocol Networking {
    func loadTaskFor(url: URL, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class MainNetworking: Networking {
    func loadTaskFor(url: URL, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url, completionHandler: completion)
    }
}
