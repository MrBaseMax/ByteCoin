//
//  CoinPriceModel.swift
//  ByteCoin
//
//  Created by Макс on 12.02.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation


struct CoinPriceModel {
    let price: Double
    let currency: String
    
    var priceString: String {
        return String( format: "%.1f", price )
    }
}
