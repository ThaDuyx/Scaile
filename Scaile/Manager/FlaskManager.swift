//
//  FileManager.swift
//  Scaile
//
//  Created by Simon Andersen on 15/05/2023.
//

import Foundation

class FlaskManager: NSObject, ObservableObject {
    
    static let shared = FlaskManager()
    
    var destinationPath: URL?
    
    func generateMIDI() {
        guard let url = URL(string: "http://127.0.0.1:5500/generate") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Error: \(httpResponse.statusCode)")
                guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else { return }
            }
            
            guard let data = data else { print("Data is empty") ; return }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(FlaskData.self, from: data)
                print("Data: \(result)")
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func generateAndFetchMIDI(urls: [URL], completion: @escaping () -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5500/generate") else {
            print("No URL returned")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { fileUrl, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let destinationPath = self.getFileName(documentPath: documentsPath, urls: urls)
            
            guard let fileUrl else {
                print("ERROR: Invalid data")
                return
            }
            
            do {
                try FileManager.default.moveItem(at: fileUrl, to: URL(filePath: destinationPath))
                
                DefaultManager.shared.midiLocation = destinationPath
                
                print("MIDI file successfully downloaded to path \(destinationPath)")
                
                completion()
            } catch {
                print("Error downloading file \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getString() {
        guard let url = URL(string: "http://127.0.0.1:5500/data") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Error: \(httpResponse.statusCode)")
                guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else { return }
            }
            
            guard let data = data else { print("Data is empty") ; return }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(FlaskData.self, from: data)
                print("Data: \(result)")
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getMIDI() {
        guard let url = URL(string: "http://127.0.0.1:5500/midi") else {
            print("No URL returned")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { fileUrl, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let destinationPath = documentsPath.appendingPathComponent("chord.mid")
            
            guard let fileUrl else {
                print("ERROR: Invalid data")
                return
            }
            
            do {
                try FileManager.default.moveItem(at: fileUrl, to: URL(filePath: destinationPath))
                
                DefaultManager.shared.midiLocation = destinationPath
                
                print("MIDI file successfully downloaded to path \(destinationPath)")
            } catch {
                print("Error downloading file \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getMIDIWithArgs(key: String, scale: String, urls: [URL], completion: @escaping () -> Void) {
        guard let baseUrl = URL(string: "http://127.0.0.1:5500/download") else {
            print("No URL returned")
            return
        }

        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["key": key, "scale": scale]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: request) { fileUrl, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            
            var name = ""
            if scale == "Random" {
                name = scale
            } else {
                name = key + " " + scale
            }
            
            let destinationPath = documentsPath.appendingPathComponent(name + " " + urls.count.formatted())
            
            guard let fileUrl else {
                print("ERROR: Invalid data")
                return
            }
            
            do {
                try FileManager.default.moveItem(at: fileUrl, to: URL(filePath: destinationPath))
                
                DefaultManager.shared.midiLocation = destinationPath
                
                completion()
                
                print("MIDI file successfully downloaded to path \(destinationPath)")
            } catch {
                print("Error downloading file \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getFileName(documentPath: NSString, urls: [URL]) -> String {
        if urls.isEmpty {
            return documentPath.appendingPathComponent("chord 1.mid")
        } else {
            return documentPath.appendingPathComponent("chord \(urls.count + 1).mid")
        }
    }
}
