//
//  TableViewController+Messages.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 20/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation
import SwiftMessages

extension TableViewController {
    
    // MARK: - Swift Messages
    
    func swiftMessagesSuccessRequest(_ pokes: [PokemonListModel]) {
        
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: "Tem informação nova!", body: "Clique no botão para atualiza-los")
        success.button?.isHidden = false
        success.button?.setTitle("Atualizar", for: .normal)
        success.buttonTapHandler = { _ in
            self.pokemonList = pokes
            self.tableView.reloadData()
            SwiftMessages.hide()
        }
        
        var successConfig = SwiftMessages.Config()
        successConfig.duration = .forever
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        
        SwiftMessages.show(config: successConfig, view: success)

    }
    
    func swiftMessagesSuccessNoRequest() {
        
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: "Os dados já estão atualizados!", body: "Clique no botão para atualiza-los")
        success.button?.isHidden = false
        success.button?.setTitle("Fechar", for: .normal)
        success.buttonTapHandler = { _ in
            SwiftMessages.hide()
        }
        
        var successConfig = SwiftMessages.Config()
        successConfig.duration = .forever
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        
        SwiftMessages.show(config: successConfig, view: success)
        
    }
    
    func swiftMessagesFailureRequest() {
        
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.error)
        success.configureDropShadow()
        success.configureContent(title: "Ops", body: "Não foi possivel atualizar os dados!")
        success.button?.isHidden = false
        success.button?.setTitle("Atualizar", for: .normal)
        success.buttonTapHandler = { _ in SwiftMessages.hide() }
        
        var successConfig = SwiftMessages.Config()
        successConfig.duration = .forever
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        
        SwiftMessages.show(config: successConfig, view: success)
        
    }
    
}
