//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinPrice(_ weatherManager: CoinManager, _ coinPrice: CoinPriceModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
	
	var delegate: CoinManagerDelegate?
	
	let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
	let apiKey = "top_secret"
	
	
	let currencyArray = [
		"USD","RUB","EUR",
		//        "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"
	]

	
	
    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    
    
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //                    print( String(data: safeData, encoding: .utf8) )
                    if let coinPrice = parseJSON(safeData) {
                        delegate?.didUpdateCoinPrice(self, coinPrice)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinPriceModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            return CoinPriceModel(price: decodedData.rate, currency: decodedData.asset_id_quote)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
