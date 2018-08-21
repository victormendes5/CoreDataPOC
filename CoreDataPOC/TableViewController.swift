//
//  TableViewController.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import UIKit
import Moya

public class TableViewController: UITableViewController {

    var pokemonList: [PokemonListModel]!
    
    weak var listDelegate: CoreDataListManagerProtocol?
    weak var saveDelegate: CoreDataSaveManagerProtocol?
    weak var loadDelegate: CoreDataLoadManagerProtocol?
    weak var cleanDelegate: CoreDataCleanManagerProtocol?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listDelegate = self
        saveDelegate = self
        loadDelegate = self
        cleanDelegate = self
        
        retrievePokesList()
    }
    
    // This code is repeated, how to remove it?
    func requestPokesWithoutReleadData() {
        let provider = MoyaProvider<Requests>()
        provider.request(.pokemon) { (result) in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let decode = try decoder.decode(AbstractionModel<PokemonListModel>.self, from: response.data)
                    
                    // Check if has new data
                    if self.pokemonList! == decode.results {
                        self.swiftMessagesSuccessNoRequest()
                    } else {
                        self.cleanDelegate?.onCleanCoreDataEntity()
                        self.onPokesRetrieved(decode.results)
                        self.swiftMessagesSuccessRequest(decode.results)
                    }
                    
                } catch let fail {
                    print(fail)
                }
            case .failure(let error):
                print(error)
            }
        }
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
