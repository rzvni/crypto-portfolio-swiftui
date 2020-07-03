//
//  PortfolioManager.swift
//  big stonks
//
//  Created by roli on 22.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class PortfolioManager: ObservableObject {
    var items: [PortfolioItem]
    
    init(){
        self.items = []
    }
    

    
    // returns true if our set contains this resort
    func contains(_ item: PortfolioData) -> Bool {
        items.map{Int($0.coinID)}.contains(item.coin.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ item: PortfolioData) {
        objectWillChange.send()
        let portfolioItem = PortfolioItem(context: UIApplication.appDelegate.persistentContainer.viewContext)
        portfolioItem.coinID = Int32(item.coin.id)
        portfolioItem.amount = Double(item.amount)
        portfolioItem.id = UUID()
        items.append(portfolioItem)
        UIApplication.appDelegate.saveContext()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ item: PortfolioData) {
        objectWillChange.send()
        guard let portfolioItem = items.filter({$0.coinID == item.coin.id}).first else { return }
        UIApplication.appDelegate.persistentContainer.viewContext.delete(portfolioItem)
        items.remove(at: items.firstIndex(of: portfolioItem)!)
        UIApplication.appDelegate.saveContext()
    }
}

