//
//  CoinStore.swift
//  big stonks
//
//  Created by roli on 19.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var portfolio: [PortfolioData] = []
    var portfolioManager = PortfolioManager()
    
    init() {
        getTop100Coins()
    }
    
    func getTop100Coins() {
        CoinmarketcapAPI().getTop100Coins { (coins) in
            self.coins = coins
            self.createPortfolio()
        }
        
    }
    
    func createPortfolio(){
        for item in portfolioManager.items {
            let coin: Coin = coins.first(where: { $0.id == Int(item.coinID) }) ?? Coin(id: 1, rank: 1, priceUsd: 0, changePercent24Hr: 0, marketCapUsd: 0, supply: 0, maxSupply: 0, symbol: "BTC", name: "Error", show: false, volume24H: 0, circulatingSupply: 0)
            portfolio.append(PortfolioData(coin: coin, amount: item.amount))
        }
    }
    
}
