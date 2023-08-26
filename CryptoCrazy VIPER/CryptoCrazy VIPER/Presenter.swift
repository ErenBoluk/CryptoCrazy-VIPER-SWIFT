//
//  Presenter.swift
//  CryptoCrazy VIPER
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation


protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interoctor : AnyInteractor? {get set}
    var view : anyView? {get set}
        
    func interacorDidDowloadCrypto(result: Result<[Crypto],Error>)
}

class CryptoProtocol: AnyPresenter {
    
    var interoctor: AnyInteractor?
    
    var view: anyView?
    
    var router: AnyRouter?
    
    
    func interacorDidDowloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            // view.update
            print("update")
        case .failure(let error):
            // view.update error
            print("error")
        }
        
    }
    
}
