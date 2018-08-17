//
//  PersistenceError.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation

public enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}
