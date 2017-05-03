//
//  ViewController.swift
//  OpenStreetMap
//
//  Created by Richard Lowe on 16/11/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

import UIKit
import MapKit

/****************************************************************************************
 ****************************************************************************************
 ****************************************************************************************

 Resources used
 http://nshipster.com/mktileoverlay-mkmapsnapshotter-mkdirections/
 http://wiki.openstreetmap.org/wiki/Tile_servers
 https://community.tibco.com/wiki/geoanalytics-resources

 
 rain
 http://weather.openportguide.de/tiles/actual/precipitation/5/4/15/15.png
 http://weather.openportguide.de/tiles/actual/precipitation/5/{z}/{x}/{y}.png
 
 http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/4/15/10.png
 http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/{z}/{x}/{y}.png
 temp
  http://weather.openportguide.de/tiles/actual/air_temperature/5/5/15/10.png
 
 wave
  http://weather.openportguide.de/tiles/actual/significant_wave_height/5/5/15/10.png
 
 Wind
  http://weather.openportguide.de/tiles/actual/wind_stream/5/5/15/10.png
  http://weather.openportguide.de/tiles/actual/gust/5/5/15/10.png
  http://weather.openportguide.de/tiles/actual/FL100_wind_barb/5/5/15/10.png
  http://weather.openportguide.de/tiles/actual/FL200_wind_barb/5/5/15/10.png
  http://weather.openportguide.de/tiles/actual/FL300_wind_barb/5/5/15/10.png
  http://weather.openportguide.de/tiles/actual/FL400_wind_barb/5/5/15/10.png
 
 ****************************************************************************************
 ****************************************************************************************
 ****************************************************************************************/

let tapRecForMapView = UITapGestureRecognizer()


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var overlayPicker: UIPickerView!
    @IBOutlet weak var baseMapPick: UIPickerView!

    //used for Location detection
    //which is currently disabled
    var manager : CLLocationManager!
    var latDelta : CLLocationDegrees = 0.005
    var lonDelta : CLLocationDegrees = 0.005
    var latitude : CLLocationDegrees = 40.7
    var longitude : CLLocationDegrees = -53.0

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        print("********* \(#function) **********")
        
        super.viewDidLoad()
        
        //MAP DELEGATE
        self.mapView.delegate = self
        
        //URL BY DEFAULT
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        
         //CENTER MAP TO THIS POI
        let location = CLLocationCoordinate2D(
            latitude: 52.335,
            longitude: -0.209
        )
        
        //SET UP ZOOM
        let viewRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 10000, 10000);
        let adjustedRegion : MKCoordinateRegion = self.mapView.regionThatFits(viewRegion);
        mapView.setRegion(adjustedRegion ,animated:true);
        showMap(temp: template, IsBaseLayer: true, clearOverlays: false, tileSize: 256)
        
        //MapView.showsUserLocation = true;
        
        
        //user location disabled
        //        manager = CLLocationManager()
        //        manager.delegate = self
        //        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //        manager.requestWhenInUseAuthorization()
        //        manager.startUpdatingLocation()
        
        //        MapView.isUserInteractionEnabled = true
        //        MapView.isMultipleTouchEnabled = true
        
        baseMapPick.delegate = self
        baseMapPick.dataSource = self
        
        overlayPicker.delegate = self
        overlayPicker.dataSource = self

        tapRecForMapView.addTarget(self, action: #selector(tappedView))
        view.addGestureRecognizer(tapRecForMapView)
        view.isUserInteractionEnabled = true
        
    }
 
    func tappedView() {
        
        print("********* \(#function) **********")
        
        var overlay : MKCachingTileOverlay? = nil
        
        do {
            overlay = try MKCachingTileOverlay(urlTemplate: "")
            overlay?.clearCache()
            print("Init of CachedTileOverlay succeeded")
        } catch {
            print("Init of CachedTileOverlay failed with unknown error")
        }
        
        overlay = nil
    }
    
    

//***************************************************************************************
//main map display
// if IsBaseLayer = true then replace base map
//***************************************************************************************
    
    func showMap(temp : String, IsBaseLayer : Bool, clearOverlays : Bool, tileSize : Int) {
        print("********* \(#function) **********")
        
        //clear existing overlays
        if clearOverlays {
            let overlays = mapView.overlays
            mapView.removeOverlays(overlays)
        }
        
        var overlay : MKTileOverlay? = nil
        
        do {
            overlay = try MKCachingTileOverlay(urlTemplate: temp)
            print("Init of CachedTileOverlay succeeded")
        } catch {
            print("Init of CachedTileOverlay failed with unknown error")
            overlay = MKTileOverlay(urlTemplate: temp)
        }
        
        overlay!.canReplaceMapContent = IsBaseLayer
        mapView.add(overlay!)
        

        
//        let overlay = MKTileOverlay (urlTemplate: temp)
//        overlay.canReplaceMapContent = IsBaseLayer
//        
//        if tileSize > 0 {
//            overlay.tileSize = CGSize(width: tileSize, height: tileSize)
//        }
//        
//        MapView.add(overlay, level: .aboveLabels)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//***************************************************************************************
//delegates for map and location
//***************************************************************************************

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("********* \(#function) **********")
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        //print (tileOverlay)
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("********* \(#function) **********")
        
        mapView.showsUserLocation = true
        
        
        let userLocation: CLLocation = locations[0]
        
        latitude  = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        latDelta = mapView.region.span.latitudeDelta
        lonDelta = mapView.region.span.longitudeDelta
        
        mapView.showsUserLocation = true
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        
    }

}

extension ViewController  : UIPickerViewDataSource, UIPickerViewDelegate{
    
    //MARK:- PickerView Delegates
    //============================================================================
    //============================================================================
    //============================================================================
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("********* \(#function) **********")
        
        // The number of columns of data
        print("********* \(#function) ********** END")
        return 1
    }
    
    //============================================================================
    //============================================================================
    //============================================================================
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("********* \(#function) **********")

        var retVal = 1
        
        switch pickerView {
        case overlayPicker :
            retVal = overlayData.count
        case baseMapPick :
            retVal = baseData.count
        default :
            retVal = 1
        }
        
        print("********* \(#function) ********** END")
        return retVal
    }
    
    //MARK:- PickerView Data Source
    //============================================================================
    //============================================================================
    //============================================================================
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("********* \(#function) **********")
        
        var retString = ""

        switch pickerView {
        case overlayPicker :
            retString = overlayData[row]

        case baseMapPick :
            retString = baseData[row]

        default :
            retString = "Error"
        }
        
        print("********* \(#function) ********** END")
        return retString
    }
    
    //============================================================================
    //============================================================================
    //============================================================================
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("********* \(#function) **********")
        
        switch pickerView {
        case overlayPicker :
            let template = overlayData[row]
            showMap(temp: template, IsBaseLayer: false, clearOverlays: false, tileSize: 256)
        case baseMapPick :
            let template = baseData[row]
            showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)
        default :
            print ("Error")        }

        print("********* \(#function) ********** END")
        
        
    }
    
    //    //============================================================================
    //    //============================================================================
    //    //============================================================================
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 18)
        
        // where data is an Array of String
        
        switch pickerView {
        case overlayPicker :
            label.text = overlayData[row]
            
        case baseMapPick :
            label.text = baseData[row]
            
        default :
            label.text = ""
        }

        return label
    }

    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        URLCache.shared.removeAllCachedResponses()
    }
    
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
}
