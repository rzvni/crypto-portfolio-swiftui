//
//  ContentView.swift
//  big stonks
//
//  Created by roli on 18.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI
import URLImage
import SwiftUICharts

let screen = UIScreen.main.bounds

struct HomeView: View {
    @ObservedObject var store = DataStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var showUpdate = false
    @State var showSearch = false
    @State var searchText = ""
    var searchArray: [Coin] {
        
        return store.coins.filter({
            $0.name!.localizedCaseInsensitiveContains(self.searchText)})
        
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(Double(self.activeView.height / 500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack (spacing: 0) {
                    HStack {
                        
                        if !self.showSearch {
                            Text("Top 100")
                                .font(.largeTitle).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                        
                        HStack {
                            
                            if self.showSearch {
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 8)
                                
                                TextField("Search assets",  text: self.$searchText)
                                
                                
                                Button(action: {
                                    withAnimation {
                                        self.showSearch.toggle()
                                        self.searchText = ""
                                    }
                                    
                                    
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.primary)
                                } .padding(.horizontal, 8)
                            } else {
                                Button(action: { self.showSearch.toggle() }) {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.primary)
                                        .font(.system(size: 16, weight: .medium))
                                        .frame(width: 36, height: 36)
                                        .background(Color("background3"))
                                        .clipShape(Circle())
                                    
                                }
                            }
                        }.padding(self.showSearch ? 10 : 0)
                            .background(Color("background3"))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                        
                    }
                    .padding([.top, .leading, .trailing], 30)
                    .padding(.bottom, 20)
                    
                    
                    if self.searchText != "" {
                        
                        
                        if searchArray.count == 0 {
                            
                            Text("No Result")
                        } else{
                            ForEach(searchArray.indices, id: \.self) { index in
                                
                                GeometryReader { geometry in
                                    CoinCard(
                                        show: self.$store.coins[index].show,
                                        coin: self.searchArray[index],
                                        active: self.$active,
                                        index: index,
                                        activeIndex: self.$activeIndex,
                                        activeView: self.$activeView
                                    )
                                        .offset(y: self.store.coins[index].show ? -geometry.frame(in: .global).minY : 0)
                                        .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                        .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                        .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                                }
                                .frame(height: 80)
                                .frame(maxWidth: self.store.coins[index].show ? .infinity : screen.width - 10)
                                .padding(.bottom,5)
                                .zIndex(self.store.coins[index].show ? 1 : 0)
                            }
                        }
                        
                    } else {
                        
                        ForEach(store.coins.indices, id: \.self) { index in
                            
                            GeometryReader { geometry in
                                CoinCard(
                                    show: self.$store.coins[index].show,
                                    coin: self.store.coins[index],
                                    active: self.$active,
                                    index: index,
                                    activeIndex: self.$activeIndex,
                                    activeView: self.$activeView
                                )
                                    .offset(y: self.store.coins[index].show ? -geometry.frame(in: .global).minY : 0)
                                    .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                    .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                //.offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                            }
                            .frame(height: 80)
                            .frame(maxWidth: self.store.coins[index].show ? .infinity : screen.width - 10)
                            .padding(.bottom,5)
                            .zIndex(self.store.coins[index].show ? 1 : 0)
                        }
                    }
                    
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct IconView: View {
    let symbol: String
    let shadow: Bool
    
    var body: some View {
        URLImage(URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(symbol).png") ?? URL(string: "")!, placeholder: Image("white")) { proxy in
            proxy.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 30, height: 30)
            
        }
        .frame(width: 36, height: 36)
        .background(Color(.white))
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(shadow ? 0.1 : 0), radius: 1, x: 0, y: 1)
        .shadow(color: Color.black.opacity(shadow ? 0.2 : 0), radius: 10, x: 0, y: 10)
    }
}

struct CoinCard: View {
    @Binding var show: Bool
    var coin: Coin
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var randomElements = (1...20).randomElements(7)
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Market Stats")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.bottom, 16)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 12.0) {
                                HStack{
                                    Text("Marketcap")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text(coin.marketCapFormatted)
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                                HStack{
                                    Text("Circulating")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text(coin.circulatingSupplyFormatted)
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                }
                                HStack{
                                    Text("Tot Supply")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text(coin.supplyFormatted)
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                                
                            }
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 12.0) {
                                HStack{
                                    Text("24h Volume")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text(coin.volume24HFormatted)
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                                HStack{
                                    Text("Max Supply")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text(String(coin.maxSupplyFormatted))
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                                HStack{
                                    Text("Rank")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text(String(coin.rank))
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                            }.padding(.trailing, 10)
                        }
                        
                    }
                    Spacer()
                }.frame(width: screen.width - 40)
                
            }
            .padding(30)
            .padding(.top, 20)
            .frame(maxWidth: show ? .infinity : screen.width - 40, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                ZStack{
                    HStack() {
                        
                        Text(String(coin.rank))
                            .foregroundColor(Color.secondary.opacity(0.7))
                            .padding(.trailing, 5)
                        
                        
                        IconView(symbol: String(coin.id), shadow: true)
                        
                        VStack(alignment: .leading) {
                            Text(coin.name!)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(show ? Color("background1") : .primary)
                            Text(coin.symbol!)
                                .foregroundColor(Color.secondary.opacity(0.7))
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(coin.priceUsdFormatted)
                                .font(.system(size: 16, weight: show ? .semibold : .medium))
                                .foregroundColor(show ? Color("background1") : .primary)
                            Text(coin.changePercent24HrFormatted)
                                .foregroundColor(coin.percentColor)
                        }.offset(x: show ? -40 : -10)
                        
                        
   
                        
                    }.padding(.top, show ? 50 : 0)
                    VStack{
                    HStack{
                        Spacer()
                    VStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.black)
                    .clipShape(Circle())
                    .opacity(show ? 1 : 0)
                    .padding()
                        }
                        Spacer()
                        }
                }
                Spacer()
                
                if show {
                    ChartView(data: ChartData([0, 5, 6, 2, 13, 4, 3, 6]))
                        .type(LineChart())
                        .style(ChartStyle(backgroundColor: ColorGradient(Color(.clear), Color(.white).opacity(0)), foregroundColor: ColorGradient(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))))
                        .frame(width: screen.width - 70, height: 200)
                        .padding(.bottom, 20)
                }
                
                
                
            }
            .padding(show ? 30 : 20)
          
                //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                .frame(maxWidth: show ? .infinity : .infinity, maxHeight: show ? 460 : 80)
                .background(Color("accent").opacity(show ? 1 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color("accent").opacity(show ? 0.2 : 0), radius: 20, x: 0, y: 20)
                .gesture(
                    show ?
                        DragGesture().onChanged { value in
                            guard value.translation.height < 300 else { return }
                            guard value.translation.height > 0 else { return }
                            
                            self.activeView = value.translation
                        }
                        .onEnded { value in
                            if self.activeView.height > 50 {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                            self.activeView = .zero
                        }
                        : nil
            )
                .onTapGesture {
                    self.show.toggle()
                    self.active.toggle()
                    if self.show {
                        self.activeIndex = self.index
                    } else {
                        self.activeIndex = -1
                    }
            }
            
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
        .gesture(
            show ?
                DragGesture().onChanged { value in
                    guard value.translation.height < 300 else { return }
                    guard value.translation.height > 0 else { return }
                    
                    self.activeView = value.translation
                }
                .onEnded { value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                }
                : nil
        )
            .edgesIgnoringSafeArea(.all)
    }
}





extension RangeExpression where Bound: FixedWidthInteger {
    func randomElements(_ n: Int) -> [Bound] {
        precondition(n > 0)
        switch self {
        case let range as Range<Bound>: return (0..<n).map { _ in .random(in: range) }
        case let range as ClosedRange<Bound>: return (0..<n).map { _ in .random(in: range) }
        default: return []
        }
    }
}

