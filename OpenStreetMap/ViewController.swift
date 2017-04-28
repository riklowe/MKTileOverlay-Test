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

 
 TileMaps
 
 below are a sample of slippy maps if have tried - most are working 
 some require access permissions - so contact the data owners
 

 format
 http://weather.openportguide.de/tiles/actual/variable/timestep/zoom/X/Y.png
 
         timestep 5 ≈ actual time at the moment of the release
         timestep 7 ≈ 2*3h = 6h in the future
         timestep 9 ≈ 4*3h = 12h in the future
         timestep 11 ≈ 6*3h = 18h in the future
         timestep 15 ≈ 10*3h = 30h in the future
         timestep 19 ≈ 14*3h = 42h in the future
         timestep 23 ≈ 18*3h = 54h in the future
         timestep 27 ≈ 22*3h = 66h in the future
 
 rain
 http://weather.openportguide.de/tiles/actual/precipitation/5/4/15/15.png
 "http://weather.openportguide.de/tiles/actual/precipitation/5/{z}/{x}/{y}"
 
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

    @IBOutlet weak var MapView: MKMapView!

    override func viewDidLoad() {
        print("********* \(#function) **********")
        
        super.viewDidLoad()
        
        //MAP DELEGATE
        self.MapView.delegate = self
        
        //URL BY DEFAULT
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        
         //CENTER MAP TO THIS POI
        let location = CLLocationCoordinate2D(
            latitude: 52.335,
            longitude: -0.209
        )
        
        //SET UP ZOOM
        let viewRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 10000, 10000);
        let adjustedRegion : MKCoordinateRegion = self.MapView.regionThatFits(viewRegion);
        MapView.setRegion(adjustedRegion ,animated:true);
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
        
    }
    
//    func clearAllOverlays() {
//    
//        //just display basic apple map
//        // but enable traffic
//        
//        let overlays = MapView.overlays
//        MapView.removeOverlays(overlays)
//        
//        MapView.showsTraffic = true
//    }

//***************************************************************************************
//main map display
// if IsBaseLayer = true then replace base map
//***************************************************************************************
    
    func showMap(temp : String, IsBaseLayer : Bool, clearOverlays : Bool, tileSize : Int) {
        print("********* \(#function) **********")
        
        //clear existing overlays
        if clearOverlays {
            let overlays = MapView.overlays
            MapView.removeOverlays(overlays)
        }
        
        let overlay = MKTileOverlay (urlTemplate: temp)
        overlay.canReplaceMapContent = IsBaseLayer
        
        if tileSize > 0 {
            overlay.tileSize = CGSize(width: tileSize, height: tileSize)
        }
        
        MapView.add(overlay, level: .aboveLabels)

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
        
        MapView.showsUserLocation = true
        
        
        let userLocation: CLLocation = locations[0]
        
        latitude  = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        latDelta = MapView.region.span.latitudeDelta
        lonDelta = MapView.region.span.longitudeDelta
        
        MapView.showsUserLocation = true
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        MapView.setRegion(region, animated: true)
        
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
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
//    {
//        
//        print("********* \(#function) **********")
//        
//        return pickerLabel
//    }
    
}

