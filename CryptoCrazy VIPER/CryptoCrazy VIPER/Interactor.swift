//
//  Interactor.swift
//  CryptoCrazy VIPER
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos(){
        let url =  URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        let tast = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            
            guard let data = data, error == nil else{
                self?.presenter?.interacorDidDowloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            print(data)
            
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interacorDidDowloadCrypto(result: .success(cryptos))
            }catch{
                self?.presenter?.interacorDidDowloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
            
        }
        
        tast.resume()
        
    }
    
}
