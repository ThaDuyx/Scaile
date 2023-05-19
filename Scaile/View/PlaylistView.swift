//
//  PlaylistView.swift
//  Scaile
//
//  Created by Simon Andersen on 19/05/2023.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var playerManager: PlayerManager
    @State var selected: URL?
    var body: some View {
        VStack {
            GeneratingView(text: "Choosing")
                .frame(width: 150)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 10, trailing: 20))
            
            List(playerManager.urls, id: \.self, selection: $selected) { url in
                Text(url.lastPathComponent)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
            }
            .onChange(of: selected) { newValue in
                playerManager.selectedMIDI = newValue?.lastPathComponent 
            }
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
