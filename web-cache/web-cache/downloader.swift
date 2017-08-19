//
//  downloader.swift
//  web-cache
//
//  Created by Kevin Peng on 2017-08-19.
//  Copyright © 2017 Kevin Peng & Julian Nadeau. All rights reserved.
//

import Foundation

class Downloader {
    static func listFiles() -> Array<URL> {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory( at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            
            // if you want to filter the directory contents you can do like this:
            let files = directoryContents.filter{ $0.pathExtension == "html" }
            return files;
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }

    static func downloadFile(url: NSURL) {
        let downloadRequest = URLRequest(url: url as URL)
        URLSession.shared.downloadTask(with: downloadRequest){ (location, response, error) in
            
            guard  let tempLocation = location, error == nil else { return }
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fullURL = documentDirectory?.appendingPathComponent((response?.suggestedFilename)!)
            
            do {
                try FileManager.default.moveItem(at: tempLocation, to: fullURL!)
            } catch CocoaError.fileNoSuchFile {
                print("No such file")
            } catch {
                print("Error downloading file : \(error)")
            }
            
            }.resume()
    }
}
