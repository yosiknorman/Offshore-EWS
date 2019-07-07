library(shiny)
library(dismo)
library(leaflet)
library(ncdf4)

# setwd("C://Users/DELL/Documents/Yosik/App/Marine_Weather_Warning_Service/")

"ftp://user_himawari16_netcdf:cirrus@202.90.199.115/Indonesia/2019"

rm(list = ls())
tempat = "PHM BKPPCK"
arah = "EAST"
waktu_awal = "15 May 2019 14:30 LT"
waktu_akhir = "16.30 LT"
event = "MODERATE to HEAVY rainfall"
lokasi_dampak = "Seribu Island Waters and Western Java Sea"
BOT = sprintf(
  "Weather Warning Update %s %s %s <br/> <br/>
Please be aware <br/>
Potential of %s over %s include %s offshore area. <br/>

This condition is predicted to continue untill %s<br/><br/>

24hrs duty forecaster<br/>

Marine Weather Services<br/>
--------------------<br/>
BADAN METEOROLOGI KLIMATOLOGI dan GEOFISIKA (BMKG)<br/>
Jl. Angkasa I No. 2 Kemayoran<br/>
10720 JAKARTA<br/>
T: +62 815 1927 3737<br/>
E: layanan.maritim@bmkg.go.id",tempat,arah, waktu_awal, event,lokasi_dampak,  tempat, waktu_akhir)

xy = data.frame(lon = 117.4167,lat = -1.08333)
radius10 = geometry(circles(xy, lonlat=TRUE, d=10000)) 
radius20 = geometry(circles(xy, lonlat=TRUE, d=20000)) 
radius30 = geometry(circles(xy, lonlat=TRUE, d=30000)) 
radius40 = geometry(circles(xy, lonlat=TRUE, d=40000))
radius50 = geometry(circles(xy, lonlat=TRUE, d=50000))

logo = "oews_files/OEWS.png"
rr <- tags$div(
  HTML('<a href="http://maritim.bmkg.go.id/?fromURL=www.bmkg.go.id"> <img border="0" alt="ImageTitle" src="oews_files/OEWS.png" width="420" height="100"> </a>')
) 

oews = leaflet() %>% setView(lng = xy$lon, lat = xy$lat, zoom = 8) %>%
  addProviderTiles(providers$Esri) %>% 
  addMarkers(lng = xy$lon, lat = xy$lat, popup = paste0("Name: PHM BKPPCK<br/>Lon: ",
                                                        xy[1],"<br/>" ,"Lat: ",xy[2], "<br/>",
             BOT)) %>%
  addPolygons(data= radius50, color = "black", stroke = 1, weight = 1, label = "50 Km") %>%
  addPolygons(data= radius40, color = "red", stroke = 1, weight = 1, label = "40 Km") %>%
  addPolygons(data= radius30, color = "red", stroke = 1, weight = 1, label = "30 Km") %>%
  addPolygons(data= radius20, color = "red", stroke = 1, weight = 1, label = "20 Km") %>%
  addPolygons(data= radius10, color = "red", label = "10 Km") %>%
  addControl(html = rr, position = "bottomright")

htmlwidgets::saveWidget(file = "oews.html", oews, selfcontained = F)
