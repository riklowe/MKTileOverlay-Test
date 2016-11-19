//
//  customOverlay.swift
//  OpenStreetMap
//
//  Created by Richard Lowe on 16/11/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

//import Foundation
//import UIKit
//import MapKit
//
//class MKHipsterTileOverlay : MKTileOverlay {
//    
//    let cache = NSCache<AnyObject, AnyObject>()
//    let operationQueue = OperationQueue()
//    
//    func URLForTilePath(path: MKTileOverlayPath) -> NSURL {
//        return NSURL(string: String(format: "http://tile.openstreetmap.com/%d/%d/%d", path.z, path.x, path.y))!
//    }
//    
//    func loadTileAtPath(path: MKTileOverlayPath, result: @escaping (NSData?, NSError?) -> Void) {
//        
//        let url = URLForTilePath(path: path)
//        if let cachedData = cache.object(forKey: url) as? NSData {
//            result(cachedData, nil)
//        } else {
//            let request = NSURLRequest(url: url as URL)
//            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: operationQueue) {
//                [weak self]
//                response, data, error in
//                if let data = data {
//                    self?.cache.setObject(data as AnyObject, forKey: url)
//                }
//                result(data as NSData?, error as NSError?)
//            }
//        }
//    }
//}
