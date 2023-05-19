//
//  PlayerManager.swift
//  Scaile
//
//  Created by Simon Andersen on 11/04/2023.
//

import Foundation
import AVFoundation
import SwiftUI

class PlayerManager: NSObject, ObservableObject {
    @Published var currentTime: Double = 0.0
    @Published var duration: Double = 1.0
    @Published var urls: [URL] = []
    
    override init() {
        super.init()
        self.getContentsOfDirectory()
    }
    
    public var selectedURL: URL?
    public var player: AVMIDIPlayer?
    
    private let fileManager = FileManager.default
    private var timer: Timer?
    
    // MARK: - Midi player functionality
    
    func play(completion: @escaping () -> Void) {
        guard let soundBankURL  = Bundle.main.url(forResource: "Piano", withExtension: "sf2") else { return }
        guard let midiUrl = fetchMIDIUrl() else { return }
        
        // - Commented but sometimes used for test purposes
        // guard let fileUrl = Bundle.main.url(forResource: "output", withExtension: "mid") else { print("MIDI file not found."); return }
        
        do {
            player = try AVMIDIPlayer(contentsOf: midiUrl, soundBankURL: soundBankURL)
            player?.prepareToPlay()
            player?.play() {
                self.player = nil
                completion()
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                self?.currentTime = self?.player?.currentPosition ?? 0.0
            }
            
            if let playerDuration = player?.duration {
                duration = playerDuration
            }
        } catch {
            print("Failed to load the MIDI file or soundbank \(error.localizedDescription)")
        }
    }
    
    func stopPlayer() {
        player?.stop()
        player = nil
        
        timer?.invalidate()
        timer = nil
    }
    
    func pausePlayer() {
        guard let midiPlayer = player else { return }
        
        midiPlayer.stop()
    }
    
    func resetPlayer() {
        guard let midiPlayer = player else { return }
        
        midiPlayer.currentPosition = 0.0
    }
    
    func isMIDIPlayerPlaying() -> Bool {
        guard let midiPlayer = player else { return false }
        
        return midiPlayer.isPlaying
    }
    
    private func fetchMIDIUrl() -> URL? {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        guard let selectedURL = selectedURL else { return nil }
        
        let midiUrl = documentDirectory.appendingPathComponent(selectedURL.lastPathComponent)
        
        guard fileManager.fileExists(atPath: midiUrl.path) else { return nil }
        
        return midiUrl
    }
    
    func getContentsOfDirectory() {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        do {
            urls = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            
            if !urls.isEmpty {
                selectedURL = urls[0]
            }
        } catch {
            print(error)
        }
    }
}
