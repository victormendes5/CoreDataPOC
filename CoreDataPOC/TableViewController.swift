//
//  TableViewController.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import UIKit

public class TableViewController: UITableViewController {

    var pokemonList: [PokemonListModel]!
    
    weak var saveDelegate: CoreDataSaveManagerProtocol?
    weak var loadDelegate: CoreDataLoadManagerProtocol?
    weak var cleanDelegate: CoreDataCleanManagerProtocol?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        saveDelegate = self
        loadDelegate = self
        cleanDelegate = self
        
        retrievePokesList()
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
