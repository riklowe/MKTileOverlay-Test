//
//  ViewController.swift
//  OpenStreetMap
//
//  Created by Richard Lowe on 16/11/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//
//http://nshipster.com/mktileoverlay-mkmapsnapshotter-mkdirections/

import UIKit
import MapKit

//var template = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"
//var overlay =  MKTileOverlay (urlTemplate: template)


/*

 http://wiki.openstreetmap.org/wiki/Tile_servers
 
 https://community.tibco.com/wiki/geoanalytics-resources
 

*/

class ViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var MapView: MKMapView!

    
    @IBAction func snow(_ sender: UIBarButtonItem) {

        //let template = "http://www.opensnowmap.org/opensnowmap-overlay/{z}/{x}/{y}.png"
        //let template = "http://tile1.maptoolkit.net/bikemap/{z}/{x}/{y}.png"

        let template = "http://tile1.maptoolkit.net/terrain/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)
        
    }
    
    @IBAction func terrain(_ sender: Any) {
        
        let template = "http://tile.stamen.com/terrain/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)

    }
    
    @IBAction func cycle(_ sender: Any) {
        
        let template = "http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)

    }
    @IBAction func toner(_ sender: Any) {

        let template = "http://a.tile.stamen.com/toner/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)

    }
    
    @IBAction func xport(_ sender: UIBarButtonItem) {
        let template = "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)
    }
    
    @IBAction func choseMap(_ sender: UIBarButtonItem) {
        let template = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)
    }
    
    @IBAction func thunder(_ sender: UIBarButtonItem) {

        //let template = "http://tile.thunderforest.com/landscape/{z}/{x}/{y}.png"
        //let template = "http://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png"
        //let template = "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png"
        let template = "http://tile.thunderforest.com/pioneer/{z}/{x}/{y}.png"
        //let template = "http://tile.thunderforest.com/transport/{z}/{x}/{y}.png"
        
        //let template = "http://tile.thunderforest.com/cycle/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)

    }
    
    @IBAction func train(_ sender: UIBarButtonItem) {

        let template = "http://tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png"
        //let template = "http://tiles.openrailwaymap.org/maxspeed/{z}/{x}/{y}.png"
        //let template = "http://tiles.openrailwaymap.org/signals/{z}/{x}/{y}.png"
        
        showMap(temp: template, olay: false, clear: true, tileSize: 512)
        
    }
    
    @IBAction func topo(_ sender: UIBarButtonItem) {
        //let template = "http://tile.opentopomap.org/{z}/{x}/{y}.png"
        //let template = "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png"
        let template = "http://www.openptmap.org/tiles/{z}/{x}/{y}.png"
        showMap(temp: template, olay: false, clear: true, tileSize: 256)
        
    }
    
    @IBAction func hike(_ sender: UIBarButtonItem) {
        let template = "http://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)
    }
    
    @IBAction func weather(_ sender: UIBarButtonItem) {
        var template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)

        //let template = "http://tile.stamen.com/toner/{z}/{x}/{y}.png"
        
        //format
        //http://weather.openportguide.de/tiles/actual/variable/timestep/zoom/X/Y.png
        
        //        timestep 5 ≈ actual time at the moment of the release
        //        timestep 7 ≈ 2*3h = 6h in the future
        //        timestep 9 ≈ 4*3h = 12h in the future
        //        timestep 11 ≈ 6*3h = 18h in the future
        //        timestep 15 ≈ 10*3h = 30h in the future
        //        timestep 19 ≈ 14*3h = 42h in the future
        //        timestep 23 ≈ 18*3h = 54h in the future
        //        timestep 27 ≈ 22*3h = 66h in the future
        
        //rain
        //http://weather.openportguide.de/tiles/actual/precipitation/5/5/15/10.png
        //http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/5/15/10.png
        
        //temp
        // http://weather.openportguide.de/tiles/actual/air_temperature/5/5/15/10.png
        
        //wave
        // http://weather.openportguide.de/tiles/actual/significant_wave_height/5/5/15/10.png
        
        //Wind
        // http://weather.openportguide.de/tiles/actual/wind_stream/5/5/15/10.png
        // http://weather.openportguide.de/tiles/actual/gust/5/5/15/10.png
        //http://weather.openportguide.de/tiles/actual/FL100_wind_barb/5/5/15/10.png
        //http://weather.openportguide.de/tiles/actual/FL200_wind_barb/5/5/15/10.png
        //http://weather.openportguide.de/tiles/actual/FL300_wind_barb/5/5/15/10.png
        // http://weather.openportguide.de/tiles/actual/FL400_wind_barb/5/5/15/10.png
        
        
        //template = "http://weather.openportguide.de/tiles/actual/surface_pressure/5/{z}/{x}/{y}.png"
        
        //template = "http://tile.openweathermap.org/clouds/{z}/{x}/{y}.png"
        
        
        //let template = "http://weather.openportguide.de/tiles/actual/air_temperature/5/{z}/{x}/{y}.png"
        template = "http://weather.openportguide.de/tiles/actual/wind_stream/5/{z}/{x}/{y}.png"
        //let template = "http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/{z}/{x}/{y}.png"
        
        showMap(temp: template, olay: true, clear: false, tileSize: 256)
        
        
        template = "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: false, tileSize: 256)

    }
    
    @IBAction func OSM(_ sender: UIBarButtonItem) {
        
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        showMap(temp: template, olay: true, clear: true, tileSize: 256)

    }

    @IBAction func Apple(_ sender: UIBarButtonItem) {
        
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        MapView.showsTraffic = true
        
        MapView.setNeedsDisplay()
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MAP DELEGATE
        //self.MapView.delegate = self
        
        //URL BY DEFAULT
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        //let template = "http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"
        //let template = "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png"
        //let template = "http://mt0.google.com/vt/x={x}&y={y}&z={z}"
        //let template = "http://tile.stamen.com/toner/{z}/{x}/{y}.png"
        //let template = "http://tile.stamen.com/terrain/{z}/{x}/{y}.png"
        //let template = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"
        
        
        //CENTER MAP TO THIS POI
        let location = CLLocationCoordinate2D(
            latitude: 52.335,
            longitude: -0.209
        )
        
        //SET UP ZOOM
        let viewRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 10000, 10000);
        let adjustedRegion : MKCoordinateRegion = self.MapView.regionThatFits(viewRegion);
        MapView.setRegion(adjustedRegion ,animated:true);
        MapView.showsUserLocation = true;
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "POINT"
//        annotation.subtitle = "Center Here"
//        MapView.addAnnotation(annotation)
        
        
        //ADDING MY CUSTOM OVERLAY CLASS
        
        //MKTileOverlay *overlay = [[MKTileOverlay alloc] initWithURLTemplate:template]; // (2)
        
        MapView.delegate = self

        showMap(temp: template, olay: true, clear: false, tileSize: 256)
        
    }
    
    func showMap(temp : String, olay : Bool, clear : Bool, tileSize : Int) {
        
        //clear existing overlays
        if clear {
            let overlays = MapView.overlays
            MapView.removeOverlays(overlays)
        }
        
        let overlay = MKTileOverlay (urlTemplate: temp)
        overlay.canReplaceMapContent = olay
        
        if tileSize > 0 {
            overlay.tileSize = CGSize(width: tileSize, height: tileSize)
        }
        
        
        
        MapView.add(overlay, level: .aboveLabels)

    }

    //delegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

