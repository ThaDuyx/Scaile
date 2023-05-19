//
//  TimerView.swift
//  Scaile
//
//  Created by Simon Andersen on 18/05/2023.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var playerManager: PlayerManager
    @State var isPlaying: Bool = false
    
    var body: some View {
        
        VStack(spacing: 30) {
            ProgressView(value: playerManager.currentTime, total: playerManager.duration)
                .tint(.red)
                .scaleEffect(x: 1, y: 1.2, anchor: .center)
                .animation(.linear, value: playerManager.currentTime)
                // .padding([.leading, .trailing], 80)
                
                HStack(spacing: 40) {
                    Button {
                        playerManager.resetPlayer()
                    } label: {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 25, height: 25)
                    }
                    
                    Button {
                        if playerManager.isMIDIPlayerPlaying() {
                            playerManager.pausePlayer()
                        } else {
                            isPlaying.toggle()
                            playerManager.play {
                                isPlaying.toggle()
                            }
                        }
                        
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 25, height: 25)
                        
                    }
                    
                    Button {
                        playerManager.stopPlayer()
                    } label: {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 25, height: 25)
                    }
                }
        }
        .frame(width: 200)
        .padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
