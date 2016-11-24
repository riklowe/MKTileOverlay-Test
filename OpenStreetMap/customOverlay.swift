//
//  customOverlay.swift
//  OpenStreetMap
//
//  Created by Richard Lowe on 16/11/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class customOverlay : MKTileOverlay {
    
    let parentDirectory = "tilecache"
    let maximumCacheAge: TimeInterval = 30.0 * 24.0 * 60.0 * 60.0
    var urlSession: URLSession?
    
    init() {
        
        print ("/{z}/{x}/{y}")
        super.init(urlTemplate: "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png")
        //super.init(urlTemplate: "http://tile.openstreetmap.org/{z}/{x}/{y}.png")
        
        
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
        
        self.minimumZ = 9
        self.maximumZ = 17
        self.canReplaceMapContent = false
        
        // The Open Sea Map tile server returns 404 for blank tiles, and also when it's
        // too heavily loaded to return a tile. We'll do our own cacheing and not use
        // NSURLSession's.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.urlCache = nil
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.urlSession = URLSession(configuration: sessionConfiguration)
        
        //Detect if app is being built for device or simulator in Swift
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let cachesDirectory = paths[0]
            print("Caches Directory:")
            print(cachesDirectory)
        #endif
        
    }
    
    //override func loadTileAtPath(path: MKTileOverlayPath, result: ((NSData?, NSError?) -> Void)) {
    
    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        
        //override func loadTile(at: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void)
        
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
        
        let parentXFolderURL = URLForTilecacheFolder().appendingPathComponent(self.cacheXFolderNameForPath(path: path))
        let tileFilePathURL = parentXFolderURL.appendingPathComponent(fileNameForTile(path: path))
        let tileFilePath = tileFilePathURL.path
        var useCachedVersion = false
        
        if FileManager.default.fileExists(atPath: tileFilePath) {
            if let fileAttributes = try? FileManager.default.attributesOfItem(atPath: tileFilePath),
                let fileModificationDate = fileAttributes[FileAttributeKey.modificationDate] as? NSDate {
                if fileModificationDate.timeIntervalSinceNow > -1.0 * maximumCacheAge {
                    useCachedVersion = true
                }
            }
        }
        
        if (useCachedVersion) {
            let cachedData = NSData(contentsOfFile: tileFilePath)
            result(cachedData as Data?, nil)
        }
        else {
            let request = URLRequest(url: self.url(forTilePath: path))
            //				print("fetching", request)
            
            
            let task = urlSession!.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
                
                if let data = data {
                    do {
                        if response != nil {
                            if let httpResponse = response as? HTTPURLResponse {
                                if httpResponse.statusCode == 200 {
                                    do {
                                        try FileManager.default.createDirectory(at: parentXFolderURL, withIntermediateDirectories: true, attributes: nil)
                                    } catch {
                                    }
                                    //data.write(to: tileFilePathURL, options: true) {
                                    
                                    try data.write(to: tileFilePathURL, options:.atomicWrite  )
                                    result(data as Data?, error as Error?)
                                }
                            }
                        }
                    } catch {
                        
                    }
                }
                
            })
            
            task.resume()
        }
    }
    
    // filename for y.png, used within the cacheXFolderNameForPath
    private func fileNameForTile(path: MKTileOverlayPath) -> String {
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
        return "\(path.y).png"
    }
    
    // path to X folder, starting from URLForTilecacheFolder
    private func cacheXFolderNameForPath(path: MKTileOverlayPath) -> String {
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
        return "\(path.contentScaleFactor)/\(path.z)/\(path.x)"
    }
    
    // folder within app's Library/Caches to use for this particular overlay
    private func URLForTilecacheFolder() -> URL {
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
        let URLForAppCacheFolder : URL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.cachesDirectory,
                                                                      in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true)
        return URLForAppCacheFolder.appendingPathComponent(parentDirectory, isDirectory: true)
    }
    
    private func URLForXFolder(path: MKTileOverlayPath) -> URL {
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
        return URLForTilecacheFolder().appendingPathComponent(cacheXFolderNameForPath(path: path), isDirectory: true)
    }
}
