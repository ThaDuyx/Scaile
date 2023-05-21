//
//  PlaylistView.swift
//  Scaile
//
//  Created by Simon Andersen on 19/05/2023.
//

import SwiftUI

struct PlaylistView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var playerManager: PlayerManager
    @State var selected: URL?
    var midURL: URL?
    
    var body: some View {
        VStack {
            GeneratingView(text: "Choosing")
                .frame(width: 150)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 10, trailing: 20))
            
            List(playerManager.urls, id: \.self, selection: $selected) { url in
                HStack {
                    Spacer()
                    
                    Text(url.lastPathComponent)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                    
                    Spacer()
                }.listRowSeparator(.hidden)
            }
            .onChange(of: selected) { newValue in
                playerManager.selectedURL = newValue
            }
            
            Button() {
                dismiss()
            } label: {
                TextGroupView(firstString: "Close ", secondString: "Selection")
                    .frame(width: 150)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 2)
                        )
            }
            .padding()
            
            Spacer()
            
        }
        .onAppear {
            playerManager.getContentsOfDirectory()
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(selected: URL(string: "www.hello.world")!)
    }
}
