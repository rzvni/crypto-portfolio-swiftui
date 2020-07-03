//
//  PortfolioItem.swift
//  big stonks
//
//  Created by roli on 21.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import Combine

struct PortfolioData: Identifiable {
    let id = UUID()
    let coin: Coin
    let amount: Double
    
    var value: Double {
        coin.priceUsd * amount
    }
}

