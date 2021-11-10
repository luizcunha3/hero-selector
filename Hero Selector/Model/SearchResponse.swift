//
//  SearchResponse.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [Hero]
}

