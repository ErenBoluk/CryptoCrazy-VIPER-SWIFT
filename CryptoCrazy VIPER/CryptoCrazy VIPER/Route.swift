//
//  Route.swift
//  CryptoCrazy VIPER
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation


protocol AnyRouter {
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter {
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()       
        return router
    }
    
    
}
