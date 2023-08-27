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
    var view : AnyView? {get set}
        
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
}

class CryptoPresenter: AnyPresenter {
    
    var interoctor: AnyInteractor? {
        didSet{
            interoctor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        print(result)
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure( _ ):
            // view.update error
            view?.update(with: "Try Again Later ...")
        }
        
    }
    
}
