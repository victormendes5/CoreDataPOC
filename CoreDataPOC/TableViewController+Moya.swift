//
//  TableViewController+Moya.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 20/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation
import Moya
import PKHUD

extension TableViewController {

    // MARK: - Requests
    
    func requestPokes() {
        let provider = MoyaProvider<Requests>()
        
        HUD.show(.progress, onView: self.view)
        provider.request(.pokemon) { (result) in
            HUD.hide()
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let decode = try decoder.decode(AbstractionModel<PokemonListModel>.self, from: response.data)
                    self.pokemonList = decode.results
                    self.cleanDelegate?.onCleanCoreDataEntity()
                    self.saveDelegate?.onPokesRetrieved(decode.results)
                    self.tableView.reloadData()
                    
                } catch let fail {
                    print(fail)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
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
    
}
