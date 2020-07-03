//
//  SearchView.swift
//  big stonks
//
//  Created by roli on 21.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

struct SearchView: View {
    @ObservedObject var store = DataStore()
    @State var searchTerm: String = ""
    @Binding var isPresented: Bool
    @State var showDetail = false
    @State var detailCoin: Coin?
    
    
    var body: some View {

        ZStack(alignment: .topLeading) {

            VStack(alignment: .center, spacing: 10) {
                HStack {
                    SearchBar(text: $searchTerm)
                    
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Text("Cancel")
                    }.padding(.trailing,20)
                }
                
                List(store.coins.filter {
                    $0.name!.localizedCaseInsensitiveContains(self.searchTerm)
                }) { coin in
                    
                    HStack {
                        IconView(symbol: String(coin.id), shadow: false)
                            .padding(.trailing, 7)
                        
                        VStack(alignment: .leading) {
                            Text(coin.name!)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                            Text(coin.symbol!)
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundColor(Color.primary.opacity(0.6))
                        }
                        Spacer()
                        Image(systemName: "plus")
                            .padding(.trailing)
                    }.padding(.vertical, 10.0)
                        .onTapGesture {
                            self.detailCoin = coin
                            self.showDetail = true
                    }     
                    
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                    
                }.navigationBarHidden(true)
                    .navigationBarTitle(Text("Home"))
                    .edgesIgnoringSafeArea([.top, .bottom])
                
            }.padding(.top, 30)
            
            
            if self.showDetail {
                BlurView(style: .systemThinMaterial).edgesIgnoringSafeArea(.all)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                
                AddCoinView(coin: self.detailCoin!, isPresented: self.$showDetail)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 35)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showDetail = false
                }
            }
            
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
        .padding(.top, 30)
    }
    
}
