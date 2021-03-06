//
//  Requests.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import Foundation
import Moya

public enum Requests {
    case pokemon
}

extension Requests: TargetType {
    public var baseURL: URL {
        return URL(string: "http://private-4ab845-test11663.apiary-mock.com")!
    }
    
    public var path: String {
        return "/listAll"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}
