//
//  Interactor.swift
//  CryptoCrazy VIPER
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation

enum NetworkError : Error {
    case networkFailed
    case parsingFailed
}

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos(){
            
            guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json")
            else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))
                    return
                }
                
                do {
                    let cryptos = try JSONDecoder().decode([Crypto].self,from: data)
                    self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
                } catch {
                    self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.parsingFailed))
                }
            }
            task.resume()
            
            
        }
    
    
}
