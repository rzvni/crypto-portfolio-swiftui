//
//  Coin.swift
//  big stonks
//
//  Created by roli on 19.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import Combine

struct Coin: Identifiable {
    var id, rank: Int
    var priceUsd, changePercent24Hr, marketCapUsd, supply, maxSupply : Double
    var symbol, name: String?
    var show: Bool
    var volume24H: Double
    var circulatingSupply: Double
    //var chartData: [Double]?
    
    var priceUsdFormatted: String {
        let price = String(format: "%.2f", priceUsd)
        return "\(price) $"
    }
    
    var changePercent24HrFormatted: String {
        let change = String(format: "%.2f", changePercent24Hr)
        return "\(change) %"
    }
    
    var percentColor: Color {
        if changePercent24Hr > 0 { return Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)) }
        return Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
    }
    
    var marketCapFormatted: String {
        let price = String(format: "%.2f", marketCapUsd/1000000000)
        return "$\(price) Bn"
    }
    
    var supplyFormatted: String {
        if supply < 1000000000 {
            let s = String(format: "%.2f", supply/1000000)
            return "\(s) M"
        }
        let s = String(format: "%.2f", supply/1000000000)
        return "\(s) Bn"
    }
    
    var maxSupplyFormatted: String {
        if maxSupply == 0 {
            return "-"
        }
        else if maxSupply < 1000000000 {
            let s = String(format: "%.2f", maxSupply/1000000)
            return "\(s) M"
        }
        let s = String(format: "%.2f", maxSupply/1000000000)
        return "\(s) Bn"
    }
    
    var circulatingSupplyFormatted: String {
        if circulatingSupply < 1000000000 {
            let s = String(format: "%.2f", circulatingSupply/1000000)
            return "\(s) M"
        }
        let s = String(format: "%.2f", circulatingSupply/1000000000)
        return "\(s) Bn"
    }
    
    var volume24HFormatted: String {
        if volume24H < 1000000000 {
            let s = String(format: "%.2f", volume24H/1000000)
            return "$\(s) M"
        }
        let s = String(format: "%.2f", volume24H/1000000000)
        return "$\(s) Bn"
    }
    
    
}
