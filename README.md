# MKTileOverlay

TileMaps

This project allows you to display various tile Maps (Slippy Maps) on your mobile device
Note : There is NO caching of the tile maps - that will come later

This is just the basic code to connect and display the maps and overlays

The code is pretty simple and self documenting 

I also include a few links to resources I read in order to make this work

 Resources used
 
 http://nshipster.com/mktileoverlay-mkmapsnapshotter-mkdirections/
 
 http://wiki.openstreetmap.org/wiki/Tile_servers
 
 https://community.tibco.com/wiki/geoanalytics-resources

 below is a sample of the maps i have tried - most are working 
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
 
 let template = "http://tile.opentopomap.org/{z}/{x}/{y}.png"
 
 let template = "http://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png"

 let template = "http://weather.openportguide.de/tiles/actual/surface_pressure/5/{z}/{x}/{y}.png"

 let template = "http://tile.openweathermap.org/clouds/{z}/{x}/{y}.png"
 
 let template = "http://weather.openportguide.de/tiles/actual/air_temperature/5/{z}/{x}/{y}.png"
 
 let template = "http://tile.stamen.com/toner/{z}/{x}/{y}.png"
 
 rain
 
 http://weather.openportguide.de/tiles/actual/precipitation/5/5/15/10.png
 
 http://weather.openportguide.de/tiles/actual/precipitation_shaded/5/5/15/10.png
 
 temperature
 
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

