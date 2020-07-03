//
//  CoinmarketcapAPI.swift
//  big stonks
//
//  Created by roli on 22.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import Combine

class CoinmarketcapAPI: ObservableObject {
    
    func getTop100Coins(completion: @escaping ([Coin]) -> ()) {
        guard let url = URL(string: "https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=01341c55-d9a1-41f5-8fdd-32a727c7e12f") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let coinArray = try! JSONDecoder().decode(CoinModel.self, from: data)
            DispatchQueue.main.async {
                
                var coins: [Coin] = []
                
                for coin in coinArray.data {
                    
                    
                    let newCoin = Coin(id: coin.id!,
                                       rank: coin.cmcRank ?? 0,
                                       priceUsd: coin.quote?.usd?.price ?? 0,
                                       changePercent24Hr: coin.quote?.usd?.percentChange24H ?? 0,
                                       marketCapUsd: (coin.quote?.usd?.marketCap ?? 0) ,
                                       supply: (coin.totalSupply ?? 0) ,
                                       maxSupply: (coin.maxSupply ?? 0) ,
                                       symbol: coin.symbol!,
                                       name: coin.name!,
                                       show: false,
                                       volume24H: coin.quote?.usd?.volume24H ?? 0,
                                       circulatingSupply: coin.circulatingSupply ?? 0)
                    
                    coins.append(newCoin)
                    
                    
                }
                
                completion(coins)
            }
            
        }.resume()
    }
    
    //    func getChartsData(completion: @escaping ([Double]) -> ()) {
    //        guard let url = URL(string: "https://api.coincap.io/v2/assets/bitcoin/history?interval=d1&start=1591999200000&end=1592620370534") else { return }
    //
    //
    //        URLSession.shared.dataTask(with: url) { (data, _, _) in
    //            print("")
    //            guard let data = data else { return }
    //
    //            let chartArray = try! JSONDecoder().decode(CoinChartData.self, from: data)
    //            DispatchQueue.main.async {
    //
    //                var charts: [Double] = []
    //
    //                for chart in chartArray.data! {
    //                    charts.append((chart.priceUsd! as NSString).doubleValue)
    //                    print((chart.priceUsd! as NSString).doubleValue)
    //                }
    //
    //                self.counter = self.counter + 1
    //                print(self.counter)
    //                completion(charts)
    //            }
    //
    //        }.resume()
    //
    //    }
    
    
}
