//
//  ContentView.swift
//  Scaile
//
//  Created by Simon Andersen on 11/04/2023.
//

import SwiftUI
import SwimplyPlayIndicator
import Shimmer

struct ContentView: View {
    @StateObject var playerManager = PlayerManager()
    @StateObject var configManager = ConfigManager()
    
    @State var isDownloading: Bool = false
    @State private var showingSheet: Bool = false
    @State private var showingPlaylist: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 10) {
                    
                    TextGroupView(firstString: "Selected ", secondString: "Scale:")
                    
                    if isDownloading {
                        SelectorGenerateView(text: "Generating")
                    } else {
                        SelectorView(firstString: configManager.selectedKey, secondString: configManager.selectedScale)
                    }
                }
                
                Spacer()
                
                PlayerView().environmentObject(playerManager)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        TextGroupView(firstString: "Select ", secondString: "MIDI")
                    }
                    .sheet(isPresented: $showingSheet) {
                        ConfigView().environmentObject(configManager)
                    }
                    .frame(width: 150)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 2)
                    )
                    
                    Button {
                        showingPlaylist.toggle()
                    } label: {
                        TextGroupView(firstString: "Show ", secondString: "MIDI")
                    }
                    .sheet(isPresented: $showingPlaylist) {
                        PlaylistView(selected: playerManager.selectedURL, midURL: playerManager.selectedURL).environmentObject(playerManager)
                    }
                    .frame(width: 150)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 2)
                    )
                    
                    if isDownloading {
                        ProgressView()
                            .tint(.red)
                            .frame(width: 150)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                            )
                    } else {
                        Button {
                            isDownloading.toggle()
                            FlaskManager.shared.getMIDIWithArgs(key: configManager.selectedKey, scale: configManager.selectedScale, urls: playerManager.urls) {
                                isDownloading.toggle()
                            }
                        } label: {
                            TextGroupView(firstString: "Generate ", secondString: "MIDI")
                        }
                        .frame(width: 150)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 2)
                        )
                    }
                }
                
                Spacer()
                
            }.padding()
        }
    }
}
