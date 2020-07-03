//
//  SearchBar.swift
//  big stonks
//
//  Created by roli on 21.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color.primary.opacity(0.3))

                TextField("Search", text: $text)
                    .foregroundColor(Color.primary.opacity(0.3))

                Group {
                    if !text.isEmpty {
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
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(Color.primary.opacity(0.1))
            .background(Color.primary.opacity(0.1))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"))
    }
}
