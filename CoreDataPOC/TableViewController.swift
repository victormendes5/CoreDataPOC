//
//  TableViewController.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import UIKit
import Moya
import CoreData

public class TableViewController: UITableViewController {

    var pokemonList: [PokemonListModel]!

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrievePokesList()
    }
    
    func requestPokes() {
        let provider = MoyaProvider<Requests>()
        provider.request(.pokemon) { (result) in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let decode = try decoder.decode(AbstractionModel<PokemonListModel>.self, from: response.data)
                    self.pokemonList = decode.results
                    self.onPokesRetrieved(decode.results)
                    self.tableView.reloadData()
                } catch let fail {
                    print(fail)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Manager list
    
    func retrievePokesList() {
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        do {
            if let pokemonList = try CoreDataStore.shared.managedObjectContext?.fetch(fetchRequest) {
                
                let list = pokemonList.map() {
                    return PokemonListModel(name: $0.name!)
                }
                
                pokemonList.isEmpty == true ? requestPokes() : didRetrievePokes(list)
                
            }
        } catch let error {
            print(error)
        }
        
    }
    
    // MARK: - Core data aux manager
    
    func didRetrievePokes(_ pokes: [PokemonListModel]) {
        self.pokemonList = pokes
        tableView.reloadData()
    }
    
    func onPokesRetrieved(_ names: [PokemonListModel]) {
        
        for name in names {
            do {
                try savePokes(poke: name)
            } catch let error {
                print(error)
            }
        }
        
    }
    
    // MARK: - Core data manager
    
    func loadPokes() throws -> [Pokemon]  {
        
        guard let managedOC = CoreDataStore.shared.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Pokemon> = NSFetchRequest(entityName: String(describing: Pokemon.self))
        
        return try managedOC.fetch(request)
        
    }
    
    func savePokes(poke: PokemonListModel) throws {
        
        guard let managedOC = CoreDataStore.shared.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newPoke = NSEntityDescription.entity(forEntityName: "Pokemon", in: managedOC) {
            let pokemon = Pokemon(entity: newPoke, insertInto: managedOC)
            pokemon.name = poke.name
            try managedOC.save()
        }
        
        throw PersistenceError.couldNotSaveObject
        
    }

    // MARK: - Table view data source

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = pokemonList else { return 0 }
        return list.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let list = pokemonList else { return UITableViewCell() }
        cell.textLabel?.text = list[indexPath.row].name
        return cell
    }

}
