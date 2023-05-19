//
//  HeaderView.swift
//  Scaile
//
//  Created by Simon Andersen on 18/05/2023.
//

import SwiftUI
import SwimplyPlayIndicator
import Shimmer

struct HeaderView: View {
    @State var state: SwimplyPlayIndicator.AudioState = .play
    private let url = URL(string: "https://www.appcoda.com")!
    
    var body: some View {
        ZStack {
            HStack {
                
                Spacer()
                
                ShareLink("", item: url)
                    .tint(.red)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                
            }
            
            HStack {
                Group {
                    Text("Sc")
                        .font(.system(size: 26, weight: .bold, design: .monospaced)) +
                    
                    Text("ai")
                        .foregroundColor(.red)
                        .font(.system(size: 26, weight: .bold, design: .monospaced)) +
                    
                    Text("le")
                        .font(.system(size: 26, weight: .bold, design: .monospaced))
                }
                
                SwimplyPlayIndicator(state: $state, count: 3, color: Color.red, style: .modern)
                    .frame(width: 18, height: 18)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
