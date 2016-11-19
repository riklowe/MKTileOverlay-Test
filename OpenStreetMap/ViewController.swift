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

class ViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var MapView: MKMapView!
    
    @IBAction func terrain(_ sender: Any) {
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        let template = "http://tile.stamen.com/terrain/{z}/{x}/{y}.png"
        
        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)
        
        MapView.setNeedsDisplay()
    }
    
    @IBAction func cycle(_ sender: Any) {
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        let template = "http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"
        
        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)
        
        MapView.setNeedsDisplay()

    }
    @IBAction func toner(_ sender: Any) {
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        let template = "http://tile.stamen.com/toner/{z}/{x}/{y}.png"
        
        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)
        
        MapView.setNeedsDisplay()

    }
    
    @IBAction func xport(_ sender: UIBarButtonItem) {
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        let template = "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png"
        
        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)
        
        MapView.setNeedsDisplay()
    }

    @IBAction func train(_ sender: UIBarButtonItem) {
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        let template = "http://tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png"
        //let template = "http://tiles.openrailwaymap.org/standard/${z}/${x}/${y}.png"
        
        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)
        
        MapView.setNeedsDisplay()
    }
    
    @IBAction func choseMap(_ sender: UIBarButtonItem) {
        
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        let template = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"

        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)

        MapView.setNeedsDisplay()
        
    }
    
    @IBAction func OSM(_ sender: UIBarButtonItem) {
        
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)

        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"

        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
        MapView.add(overlay, level: .aboveLabels)

    }

    @IBAction func Apple(_ sender: UIBarButtonItem) {
        let overlays = MapView.overlays
        MapView.removeOverlays(overlays)
        
        //        let template = "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png"
        //
        //        let overlay = MKTileOverlay (urlTemplate: template)
        //        overlay.canReplaceMapContent = true
        //
        //        MapView.add(overlay, level: .aboveLabels)
        
        //MapView.mapType = MKMapType.satelliteFlyover
        
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
        //let template = "http://tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png"
        //let template = "http://tiles.openrailwaymap.org/maxspeed/{z}/{x}/{y}.png"
        //let template = "http://tiles.openrailwaymap.org/signals/{z}/{x}/{y}.png"
        
        
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

        let overlay = MKTileOverlay (urlTemplate: template)
        overlay.canReplaceMapContent = true
        
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

