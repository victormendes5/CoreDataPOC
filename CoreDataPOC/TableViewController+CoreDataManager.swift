//
//  TableViewController+CoreDataManager.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 20/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation
import CoreData

extension TableViewController {
    
    // MARK: - Manager list
    
    func retrievePokesList() {
        do {
            if let pokemonList = try loadDelegate?.loadPokes() {
                let list = pokemonList.map() {
                    return PokemonListModel(id: Int($0.id), name: $0.name!)
                }
                pokemonList.isEmpty == true ? requestPokes() : loadDelegate?.didRetrievePokes(list)
            }
        } catch let error {
            print(error)
        }
    }
    
}

// MARK: - Core data save manager

extension TableViewController: CoreDataSaveManagerProtocol {
    
    public func onPokesRetrieved(_ names: [PokemonListModel]) {
        for name in names {
            do {
                try savePokes(poke: name)
            } catch let error {
                print(error)
            }
        }
    }
    
    public func savePokes(poke: PokemonListModel) throws {
        guard let managedOC = CoreDataStore.shared.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        if let newPoke = NSEntityDescription.entity(forEntityName: "Pokemon", in: managedOC) {
            let pokemon = Pokemon(entity: newPoke, insertInto: managedOC)
            pokemon.name = poke.name
            pokemon.id = Int16(poke.id)
            try managedOC.save()
        }
    }
    
}

// MARK: - Core data load manager

extension TableViewController: CoreDataLoadManagerProtocol {
    
    public func didRetrievePokes(_ pokes: [PokemonListModel]) {
        self.pokemonList = pokes
        self.requestPokesWithoutReleadData()
    }
    
    public func loadPokes() throws -> [Pokemon]  {
        guard let managedOC = CoreDataStore.shared.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request: NSFetchRequest<Pokemon> = NSFetchRequest(entityName: String(describing: Pokemon.self))
        return try managedOC.fetch(request)
    }
}

// MARK: - Core data delete

extension TableViewController: CoreDataCleanManagerProtocol {
    
    public func onCleanCoreDataEntity() {
        do {
            try cleanCoreDataEntity()
        } catch let error {
            print(error)
        }
    }
    
    public func cleanCoreDataEntity() throws {
        guard let managedOC = CoreDataStore.shared.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Pokemon.self))
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        try managedOC.execute(request)
    }
    
}
