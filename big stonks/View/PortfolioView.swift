//
//  PortfolioView.swift
//  big stonks
//
//  Created by roli on 20.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import QGrid

struct PortfolioView: View {
    @EnvironmentObject var portfolio: DataStore
    @ObservedObject var portfolioManager = PortfolioManager()
    
    @State var showSearch = false
    
    var body: some View {
        ZStack {
            
            VStack (spacing: 15) {
                HStack {
                    Text("Portfolio")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button(action: { self.showSearch.toggle() }) {
                        Image(systemName: "plus")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    
                }
                .padding([.top, .leading, .trailing], 30)
                
                if portfolio.portfolio.count == 0 {
                    Text("Your Portfolio is empty. Add some assets.")
                        .font(.subheadline)
                        .padding(.top, 50)
                    Spacer()
                } else {
                    List {
                        ForEach(self.portfolio.portfolio) { coin in
                            HStack {
                                IconView(symbol: String(coin.coin.id), shadow: true)
                                
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(coin.coin.symbol!)
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                        Text("$\(coin.coin.priceUsd, specifier: "%.2f")")
                                            .font(.footnote)
                                            .fontWeight(.medium)
                                            .foregroundColor(Color.primary.opacity(0.6))
                                    }
                                    HStack {
                                        Text(String(coin.amount))
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                        Text(coin.coin.changePercent24HrFormatted)
                                            .font(.footnote)
                                            .fontWeight(.medium)
                                            .foregroundColor(coin.coin.percentColor)
                                    }
                                }
                                
                                Spacer()
                                
                                Text("$\(coin.value, specifier: "%.2f")")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                
                            }.padding()
                            
                        }.onDelete { index in
                            self.portfolioManager.remove(self.portfolio.portfolio.remove(at: index.first!))
                        }
                        
                        
                        
                        
                    }.onAppear {
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundColor = UIColor.clear
                    }
                }
                
                
            }
            
            if showSearch {
                BlurView(style: .systemUltraThinMaterial).edgesIgnoringSafeArea(.all)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                SearchView(isPresented: self.$showSearch).edgesIgnoringSafeArea(.all)
            }
            
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}



