//
//  Equatable.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 21/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation

extension PokemonListModel: Equatable {
    public static func == (lhs: PokemonListModel, rhs: PokemonListModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
