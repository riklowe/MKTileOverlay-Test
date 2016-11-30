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
 
 let template = "http://www.opensnowmap.org/opensnowmap-overlay/{z}/{x}/{y}.png"
 let template = "http://tile1.maptoolkit.net/bikemap/{z}/{x}/{y}.png"
 let template = "http://tile.lonvia.de/mtb/{z}/{x}/{y}.png"
 let template = "http://tile.thunderforest.com/landscape/{z}/{x}/{y}.png"
 let template = "http://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png"
 let template = "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png"
 let template = "http://tile.thunderforest.com/transport/{z}/{x}/{y}.png"
 let template = "http://tile.thunderforest.com/cycle/{z}/{x}/{y}.png"
 
 let template = "http://tiles.openrailwaymap.org/maxspeed/{z}/{x}/{y}.png"
 let template = "http://tiles.openrailwaymap.org/signals/{z}/{x}/{y}.png"
 let template = "http://tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png"

 let template = "http://tile.opentopomap.org/{z}/{x}/{y}.png"
 let template = "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png"

 template = "http://weather.openportguide.de/tiles/actual/surface_pressure/5/{z}/{x}/{y}.png"

 template = "http://tile.openweathermap.org/clouds/{z}/{x}/{y}.png"
 let template = "http://weather.openportguide.de/tiles/actual/air_temperature/5/{z}/{x}/{y}.png"
 let template = "http://tile.stamen.com/toner/{z}/{x}/{y}.png"
 
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
 http://weather.openportguide.de/tiles/actual/precipitation/5/5/15/10.png
 http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/5/15/10.png
 
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
 
 let template = "http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/{z}/{x}/{y}.png"

 let template = "http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"
 let template = "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png"
 let template = "http://mt0.google.com/vt/x={x}&y={y}&z={z}"
 let template = "http://tile.stamen.com/toner/{z}/{x}/{y}.png"
 let template = "http://tile.stamen.com/terrain/{z}/{x}/{y}.png"
 let template = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"

 ****************************************************************************************
 ****************************************************************************************
 ****************************************************************************************/

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {


    //used for Location detection
    //which is currently disabled
    var manager : CLLocationManager!
    var latDelta : CLLocationDegrees = 0.005
    var lonDelta : CLLocationDegrees = 0.005
    var latitude : CLLocationDegrees = 40.7
    var longitude : CLLocationDegrees = -53.0

    @IBOutlet weak var MapView: MKMapView!

    override func viewDidLoad() {
        
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
        
        //MapView.showsUserLocation = true;
        
        
        //user location disabled
        //        manager = CLLocationManager()
        //        manager.delegate = self
        //        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //        manager.requestWhenInUseAuthorization()
        //        manager.startUpdatingLocation()
        
        //        MapView.isUserInteractionEnabled = true
        //        MapView.isMultipleTouchEnabled = true
        
        showMap(temp: template, IsBaseLayer: true, clearOverlays: false, tileSize: 256)
        
    }
    
    @IBAction func snow(_ sender: UIBarButtonItem) {

        let template = "http://tile1.maptoolkit.net/terrain/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: false, clearOverlays: true, tileSize: 256)
        
    }
    
    @IBAction func Lonvia(_ sender: UIBarButtonItem) {
        
        let template = "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: false, clearOverlays: true, tileSize: 256)
        
    }
    
    @IBAction func terrain(_ sender: Any) {
        
        let template = "http://tile.stamen.com/terrain/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)
    }
    
    @IBAction func cycle(_ sender: Any) {
        
        let template = "http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)

    }
    @IBAction func toner(_ sender: Any) {

        let template = "http://a.tile.stamen.com/toner/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)

    }
    
    @IBAction func xport(_ sender: UIBarButtonItem) {
        
        let template = "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)
        
    }
    
    @IBAction func choseMap(_ sender: UIBarButtonItem) {
        
        let template = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)
        
    }
    
    @IBAction func thunder(_ sender: UIBarButtonItem) {

        let template = "http://tile.thunderforest.com/pioneer/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)

    }
    
    @IBAction func train(_ sender: UIBarButtonItem) {

        let template = "http://tiles.openrailwaymap.org/maxspeed/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: false, clearOverlays: true, tileSize: 512)
        
    }
    
    @IBAction func topo(_ sender: UIBarButtonItem) {

        let template = "http://www.openptmap.org/tiles/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: false, clearOverlays: true, tileSize: 256)
        
    }
    
    @IBAction func hike(_ sender: UIBarButtonItem) {
        let template = "http://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)
    }
    
    @IBAction func weather(_ sender: UIBarButtonItem) {

        //Note : this one is different from all of the other examples
        //as it uses a base map and then overlays 2 other sources 
        // one is the opensea map
        // the other is a weather map
        
        var template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)

        template = "http://weather.openportguide.de/tiles/actual/wind_stream/5/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: false, tileSize: 256)
        
        template = "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: false, tileSize: 256)
        
//        let template = "http://tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png"
//        showMap(temp: template, IsBaseLayer: false, clearOverlays: false, tileSize: 256)


    }
    
    @IBAction func OSM(_ sender: UIBarButtonItem) {
        
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        showMap(temp: template, IsBaseLayer: true, clearOverlays: true, tileSize: 256)

    }
    
    @IBAction func Apple(_ sender: UIBarButtonItem) {
       
        //just display basic apple map
        // but enable traffic
        
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        MapView.showsTraffic = true
    }

//***************************************************************************************
//main map display
// if IsBaseLayer = true then replace base map
//***************************************************************************************
    
    func showMap(temp : String, IsBaseLayer : Bool, clearOverlays : Bool, tileSize : Int) {
        
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
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
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

