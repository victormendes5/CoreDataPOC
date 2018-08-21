//
//  PokesListProtocol.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation

public protocol CoreDataSaveManagerProtocol: class {
    func onPokesRetrieved(_ names: [PokemonListModel])
    func savePokes(poke: PokemonListModel) throws
}

public protocol CoreDataLoadManagerProtocol: class {
    func didRetrievePokes(_ pokes: [PokemonListModel])
    func loadPokes() throws -> [Pokemon]
}

public protocol CoreDataCleanManagerProtocol: class {
    func onCleanCoreDataEntity()
    func cleanCoreDataEntity() throws
}
