//
//  AddCoinView.swift
//  big stonks
//
//  Created by roli on 21.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import CoreData

struct AddCoinView: View {
    @EnvironmentObject var portfolio: DataStore
    @ObservedObject var portfolioManager = PortfolioManager()
    @State var text = ""
    var coin: Coin
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var amount: Double { Double(text) ?? 0 }
    
    var totalValue: Double {
        return coin.priceUsd * amount
    }
    
    
    var body: some View {
        
        Background {
            ZStack {
                VStack(spacing: 50) {
                    
                    HStack {
                        IconView(symbol: String(self.coin.id), shadow: false)
                        
                        Text(self.coin.name!)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                        Text(self.coin.symbol!)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.primary.opacity(0.6))
                    }
                    
                    HStack {
                        HStack {
                            Spacer()
                            
                            TextField("Search", text: self.$text)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color.primary.opacity(0.3))
                            
                            Group {
                                if !self.text.isEmpty {
                                    Button(action: {
                                        self.text = ""
                                    }, label: {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(Color.primary.opacity(0.5))
                                        
                                    })
                                } else {
                                    EmptyView()
                                }
                            }
                        }
                        .frame(width: 200)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .foregroundColor(Color.primary.opacity(0.1))
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(10.0)
                    }.padding(.horizontal)
                    
                    VStack {
                        Text("$\(self.totalValue, specifier: "%.2f")")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                            .padding(.bottom,6)
                        Text("Total Value")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.primary.opacity(0.6))
                        
                    }.padding()
                    
                    Button(action: {
                        self.portfolioManager.add(PortfolioData(coin: self.coin, amount: self.amount))
                        
                        self.portfolio.portfolio.append(PortfolioData(coin: self.coin, amount: self.amount))
                        self.isPresented = false
                    }) {
                        Text("Add to Portfolio").padding()
                    }
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(30)
                    .navigationBarHidden(true)
                    .navigationBarTitle(Text("Home"))
                    .edgesIgnoringSafeArea([.top, .bottom])
                }
                
                //idk why but if i delete this vstack the view gets messed up..
                //but thats a problem for future me
                VStack {
                    HStack {
                        
                        Spacer()
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.isPresented = false
                }
                
            }
        }.onTapGesture {
            self.endEditing()
        }
        
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct Background<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.white.opacity(0.01)
            .overlay(content)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
