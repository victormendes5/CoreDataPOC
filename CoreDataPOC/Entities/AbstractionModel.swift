//
//  AbstractionModel.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation

public struct AbstractionModel<T>: Codable where T : Codable {
    public let results: [PokemonListModel]
}
