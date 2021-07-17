//
//  CoinData.swift
//  ByteCoin
//
//  Created by Макс on 12.02.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable{
    let rate: Double //цена
    let asset_id_quote: String //валюта
}
