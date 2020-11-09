//
//  Person+Extension.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 8/11/20.
//

import Foundation

extension Person {
    var origin: String {
        let planet = homeworld?.name ?? ""
        if let specie = species?.name {
            return "\(specie) from \(planet)"
        } else {
            return "From \(planet)"
        }
    }
}
