//
//  PokesListProtocol.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation

public protocol CoreDataManagerProtocol: class {
    func loadPokes()
    func savePokes(poke: PokemonListModel) throws
}

public protocol CoreDataAuxManagerProtocol: class {
    func didRetrievePokes(_ pokes: [PokemonListModel])
    func onPokesRetrieved(_ names: [PokemonListModel])
}
