//
//  Hero.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import Foundation

struct HeroImage: Decodable {
    let url: String
}

struct Hero: Decodable {
    let id: String
    let name: String
    let image: HeroImage
}
