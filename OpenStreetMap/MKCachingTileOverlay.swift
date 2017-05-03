//
//  MKCachingTileOverlay.swift
//  PSFT
//
//  Created by Richard Lowe on 23/02/2017.
//  Copyright © 2017 Richard Lowe. All rights reserved.
//

import Foundation
import MapKit

enum MKCachingTileOverlayError: Error {
    case InitialDirectoryCreationFailed
}

class MKCachingTileOverlay: MKTileOverlay {
    
    public var cachingEnabled = true
    
    private let localFileManager = FileManager.default
    private let cachedTilesDirectory = "MKCachingTileOverlay Tiles"
    
    private var cachingTileTemplateURL: String
    private var cachingTileDirectoryTemplateURL: String
    
    //    var applicationSupportDirectory = ""
    var cacheDirectory : URL? = nil
    var tilesDirectory : URL? = nil
    
    init(urlTemplate URLTemplate: String) throws {
        print("********* \(#function) **********")
        
        //Generate Caching Directory and Path from URLTemplate and cachedTilesDirectory
        let templateTilesDirectory = URLTemplate.addingPercentEncoding(withAllowedCharacters: .alphanumerics)?.replacingOccurrences(of: "%", with: "")
        let applicationSupportDirectory = localFileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        cacheDirectory = applicationSupportDirectory.appendingPathComponent(cachedTilesDirectory, isDirectory: true)
        tilesDirectory = cacheDirectory?.appendingPathComponent(templateTilesDirectory!, isDirectory: false)
        
        //        print("==================================================================")
        //        print ("App Sup : \(applicationSupportDirectory)")
        //        print ("Cache   : \(cacheDirectory)")
        //        print ("tiles   : \(tilesDirectory)")
        
        //Create Caching Directory
        do {
            try localFileManager.createDirectory(at: tilesDirectory!, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw MKCachingTileOverlayError.InitialDirectoryCreationFailed
        }
        
        //Generate URL-Templates for Caching Tiles
        cachingTileDirectoryTemplateURL = (tilesDirectory?.absoluteString.appending("/{z}").appending("/{x}"))!
        cachingTileTemplateURL = cachingTileDirectoryTemplateURL.appending("/{y}")
        
        //print("==================================================================")
        //print (cachingTileTemplateURL)
        
        //Init Superclass
        super.init(urlTemplate: URLTemplate)
        //Debug.log("E")
        
        print ("number of cached files : \(countCacheFiles())")
        
    }
    
    public func url(forCacheTilePath path: MKTileOverlayPath) -> URL {
        //Debug.log("S")
        let z = String(path.z)
        let x = String(path.x)
        let y = String(path.y)
        let path = cachingTileTemplateURL.replacingOccurrences(of: "{z}", with: z).replacingOccurrences(of: "{x}", with: x).replacingOccurrences(of: "{y}", with: y)
        //print(path)
        //Debug.log("E")
        return URL(string: path)!
    }
    
    private func url(forCacheTileDirectory path: MKTileOverlayPath) -> URL {
        //Debug.log("S")
        let z = String(path.z)
        let x = String(path.x)
        let path = cachingTileDirectoryTemplateURL.replacingOccurrences(of: "{z}", with: z).replacingOccurrences(of: "{x}", with: x)
        //print(path)
        //Debug.log("E")
        return URL(string: path)!
    }
    
    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        
        //Debug.log("S")
        //print ("-----------------------------------------------------------------------------------")
        if !cachingEnabled{
            super.loadTile(at: path, result: result)
            //Debug.log("E")
            return
        }
        
        //print ("path : \(path)")
        //Check if file exists
        let tileURLInCache = url(forCacheTilePath: path)
        let tileDirectoryURLInCache = url(forCacheTileDirectory: path)
        
        let inCache = localFileManager.fileExists(atPath: tileURLInCache.path)
        
        if !inCache {
            
            print("Not found in cache")
            
            //Load Data and write to Cache
            super.loadTile(at: path){(data: Data?, error: Error?)-> Void in
                if data != nil {
                    //Received Data -> Store in Cache
                    let callbackFileManager = FileManager.default
                    //Create Directories
                    do {
                        try callbackFileManager.createDirectory(at: tileDirectoryURLInCache, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        print("Failed Creating Tile Directory: \(tileDirectoryURLInCache.path)")
                    }
                    //Write File
                    callbackFileManager.createFile(atPath: tileURLInCache.path, contents: data, attributes: nil)
                }
                result(data, error)
            }
        } else {
            
            //print("found in cache")
            
            //let today = Date().addingTimeInterval(60 * 60 * 24 * 6)
            let today = Date()
            //print (today)
            
            do {
                let fileAttrib = try localFileManager.attributesOfItem(atPath: (tileURLInCache.path) )
                //print ("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
                
                let createDate = fileAttrib[FileAttributeKey.creationDate]! as! Date
                //print ("createDate : \(createDate)")
                
                //let fileType = fileAttrib[FileAttributeKey.type]!
                //print ("fileType : \(fileType)")
                
                //let fileSize = fileAttrib[FileAttributeKey.size]!
                //print ("fileSize : \(fileSize)")
                
                let daysOld = createDate.days(from: today)  //returns -3 for items cached 3 days ago
                //print ("daysOld : \(daysOld)")
                
                if daysOld < -5 {
                    
                    //reload data
                    print("but cache data is over 5 days old - so reload")
                    
                    //Load Data and write to Cache
                    super.loadTile(at: path){(data: Data?, error: Error?)-> Void in
                        if data != nil {
                            //Received Data -> Store in Cache
                            let callbackFileManager = FileManager.default
                            //Create Directories
                            do {
                                try callbackFileManager.createDirectory(at: tileDirectoryURLInCache, withIntermediateDirectories: true, attributes: nil)
                            } catch {
                                print("Failed Creating Tile Directory: \(tileDirectoryURLInCache.path)")
                            }
                            //Write File
                            callbackFileManager.createFile(atPath: tileURLInCache.path, contents: data, attributes: nil)
                        }
                        result(data, error)
                    }
                    
                } else {
                    
                    //Load data from Cache
                    print("Using cached maps")
                    
                    if let data = localFileManager.contents(atPath: tileURLInCache.path) {
                        result(data, nil)
                    } else {
                        print("Reading cached Tile \(tileURLInCache.path) from Filesystem failed")
                        super.loadTile(at: path) { (data: Data?, error: Error?)-> Void in
                            result(data, error)
                        }
                    }
                }
                
            } catch let error {
                print ("\(error)")
            }
            
        }
        //Debug.log("E")
        
    }
    
    func clearCache() {
        
        print("********* \(#function) **********")
        print ("===============================")
        print (cacheDirectory?.absoluteString ?? "empty")
        print ("===============================")
        
        do {
            try FileManager.default.removeItem(at: cacheDirectory!)
            print ("files removed")
        } catch {
            
            print ("unable to remove files")
        }
        
    }
    
    
    func countCacheFiles() -> Int {
        
        //count / access files in a directory
        
        var counter = 0
        do {
            let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
            
            let enumerator = FileManager.default.enumerator(at: cacheDirectory!,
                                                            includingPropertiesForKeys: resourceKeys,
                                                            options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                                                                print("directoryEnumerator error at \(url): ", error)
                                                                return true
            })!
            
            for case let fileURL as URL in enumerator {
                counter += 1
                let resourceValues = try fileURL.resourceValues(forKeys: Set(resourceKeys))
                //print(counter, fileURL.path, resourceValues.creationDate!, resourceValues.isDirectory!)
            }
            
        } catch {
            print(error)
        }
        
        return counter
    }
    
}


/*
 
 [__C.FileAttributeKey(_rawValue: NSFileOwnerAccountName): mobile,
 __C.FileAttributeKey(_rawValue: NSFilePosixPermissions): 420,
 __C.FileAttributeKey(_rawValue: NSFileSystemNumber): 16777219,
 __C.FileAttributeKey(_rawValue: NSFileReferenceCount): 1,
 __C.FileAttributeKey(_rawValue: NSFileSystemFileNumber): 4315547558,
 __C.FileAttributeKey(_rawValue: NSFileCreationDate): 2017-05-02 09:54:50 +0000,
 __C.FileAttributeKey(_rawValue: NSFileProtectionKey): NSFileProtectionCompleteUntilFirstUserAuthentication,
 __C.FileAttributeKey(_rawValue: NSFileType): NSFileTypeRegular,
 
 __C.FileAttributeKey(_rawValue: NSFileGroupOwnerAccountName): mobile,
 __C.FileAttributeKey(_rawValue: NSFileGroupOwnerAccountID): 501,
 __C.FileAttributeKey(_rawValue: NSFileModificationDate): 2017-05-02 09:54:50 +0000,
 __C.FileAttributeKey(_rawValue: NSFileSize): 662, 
 __C.FileAttributeKey(_rawValue: NSFileExtensionHidden): 0, 
 __C.FileAttributeKey(_rawValue: NSFileOwnerAccountID): 501
 ]
 
 
 
 
 
 
 */
