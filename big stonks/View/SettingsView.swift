//
//  SettingsView.swift
//  big stonks
//
//  Created by roli on 23.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack (spacing: 15) {
            HStack {
                Text("Settings")
                    .font(.largeTitle).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
            }
            .padding([.top, .leading, .trailing], 30)
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
