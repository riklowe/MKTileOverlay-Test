//
//  Data.swift
//  OpenStreetMap
//
//  Created by Richard Lowe on 27/04/2017.
//  Copyright © 2017 Richard Lowe. All rights reserved.
//
/*
TileMaps

below are a sample of slippy maps if have tried - most are working
some require access permissions - so contact the data owners

format for weather.openportguide.de
 
http://weather.openportguide.de/tiles/actual/variable/timestep/zoom/X/Y.png

timestep 5 ≈ actual time at the moment of the release
timestep 7 ≈ 2*3h = 6h in the future
timestep 9 ≈ 4*3h = 12h in the future
timestep 11 ≈ 6*3h = 18h in the future
timestep 15 ≈ 10*3h = 30h in the future
timestep 19 ≈ 14*3h = 42h in the future
timestep 23 ≈ 18*3h = 54h in the future
timestep 27 ≈ 22*3h = 66h in the future
 
 example "http://weather.openportguide.de/tiles/actual/gust/5/{z}/{x}/{y}.png"

 */

import Foundation

// let template = "http://tile.lonvia.de/mtb/{z}/{x}/{y}.png"

//size 512
//"http://tiles.openrailwaymap.org/maxspeed/{z}/{x}/{y}.png",
//"http://tile.thunderforest.com/landscape/{z}/{x}/{y}@2x.png",
//"http://tile.thunderforest.com/outdoors/{z}/{x}/{y}@2x.png",
//"http://tile.thunderforest.com/pioneer/{z}/{x}/{y}@2x.png",
//"http://tile.thunderforest.com/transport-dark/{z}/{x}/{y}@2x.png",
//"http://tile.thunderforest.com/transport/{z}/{x}/{y}@2x.png",
//"http://tile.thunderforest.com/cycle/{z}/{x}/{y}@2x.png",
//"http://tiles.openrailwaymap.org/maxspeed/{z}/{x}/{y}.png",
//"http://tiles.openrailwaymap.org/signals/{z}/{x}/{y}.png",
//"http://tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png",
//"http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{x}/{y}.jpg",


//not working 
//    "http://tile.opentopomap.org/tiles/{z}/{x}/{y}.png",
//    "http://tile.osm.kosmosnimki.ru/kosmo/{z}/{x}/{y}.png",
//    "http://tile.osm.kosmosnimki.ru/night/{z}/{x}/{y}.png",
//    "http://tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png",

//    "http://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png",
//    "http://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",


//    "http://tile.bbbike.org/osm/bbbike-smoothness/{z}/{x}/{y}.png",
//    "http://tile.bbbike.org/osm/mapnik/{z}/{x}/{y}.png",
//    "http://tile.bbbike.org/osm/bbbike-cycleway/{z}/{x}/{y}.png",
//    "http://tile.bbbike.org/osm/bbbike-green/{z}/{x}/{y}.png",
//    "http://tile.bbbike.org/osm/bbbike-unlit/{z}/{x}/{y}.png",
//    "http://tile.bbbike.org/osm/bbbike/{z}/{x}/{y}.png",
//    "http://tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
//    "http://tile.openstreetmap.fr/openriverboatmap/{z}/{x}/{y}.png",
//    "http://tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png",
//    "http://tiles.osm2world.org/osm/pngtiles/n/{z}/{x}/{y}.png",
//    "http://tiles.mapbox.com/v3/pinterest.map-ho21rkos/{z}/{x}/{y}.png",
//    "http://gtile.deinplan.de/zzz/{z}/{x}/{y}.png",
//    "http://ec2.cdn.ecmaps.de/WmsGateway.ashx.jpg?TileX={x}&TileY={y}&ZoomLevel={z}&Experience=falk&MapStyle=Falk%20Base",

//    "http://maps-for-free.com/layer/relief/z{z}/row{y}/{z}_{x}-{y}.jpg",

//    "http://otile1.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png",
//    "http://otile1.mqcdn.com/tiles/1.0.0/sat/{z}/{x}/{y}.png",

//    "http://ttiles01.mqcdn.com/tiles/1.0.0/vy/hyb/{z}/{x}/{y}.png",
//    "http://ttiles01.mqcdn.com/tiles/1.0.0/vy/sat/{z}/{x}/{y}.png",
//    "http://www.opensnowmap.org/opensnowmap-overlay/{z}/{x}/{y}.png",

//    "http://1.aerial.maps.api.here.com/maptile/2.1/maptile/newest/hybrid.day/{z}/{x}/{y}.png",

//    "http://tiles.mapbox.com/v3/tmcw.map-j5fsp01s/{z}/{x}/{y}.png",
//    "http://tiles.mapbox.com/v3/tmcw.map-j5fsp01s/{z}/{x}/{y}.png",
//    "http://tiles.mapbox.com/v4/heyitsgarrett.kf2a2nb1/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiaGV5aXRzZ2FycmV0dCIsImEiOiIwdWt5ZlpjIn0.73b7Y47rgFnSD7QCNeS-zA",
//    "http://tiles.mapbox.com/v4/matt.72ef5189/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiZHVuY2FuZ3JhaGFtIiwiYSI6IlJJcWdFczQifQ.9HUpTV1es8IjaGAf_s64VQ",
//    "http://tiles.mapbox.com/v4/peterqliu.9d05be4d/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiZHVuY2FuZ3JhaGFtIiwiYSI6IlJJcWdFczQifQ.9HUpTV1es8IjaGAf_s64VQ",

let overlayData = [
    "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png",
    "http://www.openptmap.org/tiles/{z}/{x}/{y}.png",
    "http://gps-tile.openstreetmap.org/lines/{z}/{x}/{y}.png",
    "http://korona.geog.uni-heidelberg.de/tiles/adminb/x={x}&y={y}&z={z}",
    "http://www.openptmap.org/tiles/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/wind_stream/5/{z}/{x}/{y}.png",
    "http://gps-tile.openstreetmap.org/lines/{z}/{x}/{y}.png",
    "http://tile.openstreetmap.se/hydda/roads_and_labels/{z}/{x}/{y}.png",
    "http://tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png",
    "http://korona.geog.uni-heidelberg.de/tiles/adminb/x={x}&y={y}&z={z}",
    "http://korona.geog.uni-heidelberg.de/tiles/asterh/x={x}&y={y}&z={z}",
    "http://korona.geog.uni-heidelberg.de/tiles/hybrid/x={x}&y={y}&z={z}",
    "http://t0.beta.itoworld.com/124/baafeeae799c1dcc732ea30dd4ae5c97/{z}/{x}/{y}.png",
    "http://t0.beta.itoworld.com/215/3f91703263bfa5c9376e129ada11252b/{z}/{x}/{y}.png",
    "http://t0.beta.itoworld.com/69/84f7729ed2e9b4c7e2aed58e8fb171fe/{z}/{x}/{y}.png",
    "http://tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png",
    "http://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png",
    "http://vec01.maps.yandex.net/tiles?l=skl&x={x}&y={y}&z={z}",
    "http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}.jpg",
    "http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Reference_Overlay/MapServer/tile/{z}/{x}/{y}.jpg",
    "http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Transportation/MapServer/tile/{z}/{y}/{x}.jpg",
    "http://weather.openportguide.de/tiles/actual/precipitation/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/air_temperature/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/significant_wave_height/5/{z}/{x}/{y}.png",
    
    "http://weather.openportguide.de/tiles/actual/wind_stream/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/gust/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/FL100_wind_barb/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/FL200_wind_barb/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/FL300_wind_barb/5/{z}/{x}/{y}.png",
    "http://weather.openportguide.de/tiles/actual/FL400_wind_barb/5/{z}/{x}/{y}.png"


]

let baseData = [
    "http://tile.openstreetmap.org/{z}/{x}/{y}.png",

    "http://korona.geog.uni-heidelberg.de/tiles/roadsg/x={x}&y={y}&z={z}",
    "http://korona.geog.uni-heidelberg.de/tiles/roads/x={x}&y={y}&z={z}",
    
    "http://tile1.maptoolkit.net/terrain/{z}/{x}/{y}.png",

    "http://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png",

    "http://a.tile.stamen.com/toner/{z}/{x}/{y}.png",
    "http://a.tile.stamen.com/toner-background/{z}/{x}/{y}.png",
    "http://tile.stamen.com/terrain/{z}/{x}/{y}.png",
    "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png",
    
    "http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png",
    "http://tile.opencyclemap.org/transport/{z}/{x}/{y}.png",
    "http://tile2.opencyclemap.org/transport/{z}/{x}/{y}.png",

    "http://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png",
    "http://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png",
    "http://tiles.wmflabs.org/osm-no-labels/{z}/{x}/{y}.png",
    
    "http://tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png",
    "http://tile.openstreetmap.se/hydda/base/{z}/{x}/{y}.png",
    "http://tile.openstreetmap.se/hydda/full/{z}/{x}/{y}.png",
    "http://tile.openstreetmap.se/osm/{z}/{x}/{y}.png",
    
    "http://tile.thunderforest.com/mobile-atlas/{z}/{x}/{y}.png",
    "http://tile.thunderforest.com/neighbourhood/{z}/{x}/{y}.png",
    "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png",
    "http://tile.thunderforest.com/cycle/{z}/{x}/{y}.png",
    "http://tile.thunderforest.com/pioneer/{z}/{x}/{y}.png",
    "http://tile.hosted.thunderforest.com/komoot-2/{z}/{x}/{y}.png",
    
    "http://tiles.maps.sputnik.ru/tiles/kmt2/{z}/{x}/{y}.png",
    
    "http://ec2.cdn.ecmaps.de/WmsGateway.ashx.jpg?TileX={x}&TileY={y}&ZoomLevel={z}&Experience=falk&MapStyle=Falk%20OSM",
    "http://ec2.cdn.ecmaps.de/WmsGateway.ashx.jpg?TileX={x}&TileY={y}&ZoomLevel={z}&Experience=kompass&MapStyle=KOMPASS%20Touristik",
    "http://ec2.cdn.ecmaps.de/WmsGateway.ashx.jpg?TileX={x}&TileY={y}&ZoomLevel={z}&Experience=kompass&MapStyle=su",
    "http://ec2.cdn.ecmaps.de/WmsGateway.ashx.jpg?TileX={x}&TileY={y}&ZoomLevel={z}&Experience=kompass&MapStyle=wi",
    "http://ec2.cdn.ecmaps.de/WmsGateway.ashx.jpg?TileX={x}&TileY={y}&ZoomLevel={z}&Experience=kompass&MapStyle=Winter%20Touristik",
    
    "http://gsp2.apple.com/tile?api=1&style=slideshow&layers=default&lang=de_DE&z={z}&x={x}&y={y}&v=9",
    
    "http://map1.viamichelin.com/map/mapdirect?map=light&z={z}&x={x}&y={y}&format=png&version=201503191157&layer=background",
    "http://map1.viamichelin.com/map/mapdirect?map=viamichelin&z={z}&x={x}&y={y}&format=png&version=201503191157&layer=background",
    
    "http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}.jpg",
    "http://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}",
    "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}",
    
    "http://tile.memomaps.de/tilegen/{z}/{x}/{y}.png",
    
    "http://tiles1.sigma-dc-control.com/layer5/{z}/{x}/{y}.png",
    "http://tiles1.sigma-dc-control.com/layer8/{z}/{x}/{y}.png",
    
    "http://tiles2.skobbler.net/osm_tiles2/{z}/{x}/{y}.png",
    
    "http://www.wanderreitkarte.de/topo/{z}/{x}/{y}.png",
    
    "http://1.aerial.maps.api.here.com/maptile/2.1/maptile/newest/hybrid.day/{z}/{x}/{y}/256/png8?app_id=g7UuRR708Tsut4YSnDLy&token=fVzaDAdRK62zo3CuNcPtDg&lg=ENG",

    "http://1.aerial.maps.api.here.com/maptile/2.1/maptile/newest/satellite.day/{z}/{x}/{y}/256/png8?app_id=g7UuRR708Tsut4YSnDLy&token=fVzaDAdRK62zo3CuNcPtDg&lg=ENG",
    "http://1.aerial.maps.api.here.com/maptile/2.1/maptile/newest/terrain.day/{z}/{x}/{y}/256/png8?app_id=g7UuRR708Tsut4YSnDLy&token=fVzaDAdRK62zo3CuNcPtDg&lg=ENG",

    "http://1.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.transit/{z}/{x}/{y}/256/png8?app_id=g7UuRR708Tsut4YSnDLy&token=fVzaDAdRK62zo3CuNcPtDg&lg=ENG",
    "http://1.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day/{z}/{x}/{y}/256/png8?app_id=g7UuRR708Tsut4YSnDLy&token=fVzaDAdRK62zo3CuNcPtDg&lg=ENG",
    "http://1.traffic.maps.api.here.com/maptile/2.1/traffictile/newest/normal.day/{z}/{x}/{y}/256/png8?app_id=g7UuRR708Tsut4YSnDLy&token=fVzaDAdRK62zo3CuNcPtDg&lg=ENG",
    
    "http://tile.geofabrik.de/15173cf79060ee4a66573954f6017ab0/{z}/{x}/{y}.png",
    
    "http://server.arcgisonline.com/ArcGIS/rest/services/World_Physical_Map/MapServer/tile/{z}/{y}/{x}.jpg",
    "http://server.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}.jpg",
    "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.jpg",
    "http://services.arcgisonline.com/ArcGIS/rest/services/Ocean/World_Ocean_Base/MapServer/tile/{z}/{y}/{x}.jpg",
    
    "http://tile1.maptoolkit.net/terrain/{z}/{x}/{y}.png",
    
    "http://tiles.lyrk.org/ls/{z}/{x}/{y}?apikey=e9f8eb3824344d18a5b4b657773caf30",
    
    "http://vec02.maps.yandex.net/tiles?l=map&v=4.40&x={x}&y={y}&z={z}",
    "http://sat01.maps.yandex.net/tiles?l=sat&v=1.35.0&x={x}&y={y}&z={z}",
    
    "http://worldtiles1.waze.com/tiles/{z}/{x}/{y}.png"
]
