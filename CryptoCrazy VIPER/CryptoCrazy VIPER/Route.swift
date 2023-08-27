//
//  Route.swift
//  CryptoCrazy VIPER
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController & AnyView

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.interoctor = interactor
        presenter.router = router
        presenter.view = view
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
