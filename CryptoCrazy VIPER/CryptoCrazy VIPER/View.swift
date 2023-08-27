//
//  View.swift
//  CryptoCrazy VIPER
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos: [Crypto])
    func update(with error: String)
}


class detailViewController : UIViewController{
    
    var currency = ""
    var price = ""
    
    private let currencyLabel : UILabel = {
            let label = UILabel()
            label.isHidden = true
            label.text = "Currency"
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            return label
        
    }()
    private let priceLabel : UILabel = {
            let label = UILabel()
            label.isHidden = true
            label.text = "Price"
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            return label
        
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"cryptocurrency.png")
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(priceLabel)
        view.addSubview(currencyLabel)
        view.addSubview(imageView)
        view.backgroundColor = .white
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencyLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)

        priceLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 + 50, width: 200, height: 50)
        
        
        let imgW = view.frame.width * 0.5
        
        let imgY = (view.frame.height / 2 - imgW ) - 25
        
        imageView.frame = CGRect(x: imgW - imgW / 2, y:  imgY , width: imgW, height: imgW)
        currencyLabel.text = self.currency
        priceLabel.text = self.price
        
        priceLabel.isHidden = false
        currencyLabel.isHidden = false
    }
}


class CryptoViewController:UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{
    
    var presenter: AnyPresenter?
    var cryptos : [Crypto] = []
    
    private let tableView : UITableView = {
            let table = UITableView()
            table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            table.isHidden = true
            return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading ..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100 , y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .systemPurple
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = detailViewController()
        detailVC.currency = cryptos[indexPath.row].currency
        detailVC.price = cryptos[indexPath.row].price
        print(cryptos[indexPath.row])
        present(detailVC, animated: true)
    }
    
    
    func update(with cryptos: [Crypto]) {
        
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
            
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
        
    }
    
    
}
