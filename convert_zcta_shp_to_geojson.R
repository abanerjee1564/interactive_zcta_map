library(sf)
library(dplyr)

# adjust path to your shapefile folder
shp <- st_read("/Users/akashbanerjee/Downloads/nhgis0084_shape/nhgis0084_shapefile_tl2020_us_zcta_2020/US_zcta_2020.shp")   # reads shapefile

# reproject to WGS84 lon/lat
shp_ll <- st_transform(shp, 4326)

# Simplify geometry for web (tolerance in map units; tune as needed)
shp_simp_ll <- st_simplify(st_make_valid(shp_ll), 
                           dTolerance = 500)

# Make sure GEOID20 is a string (important)
shp_simp_ll$GEOID20 <- as.character(shp_simp_ll$GEOID20)

# Get rid of geometry collections
test <- st_geometry_type(shp_simp_ll$geometry)
indices <- which(sapply(test, function(x) "GEOMETRYCOLLECTION" %in% x))

shp_simp_ll$remove <- 0

for(i in indices) {
  shp_simp_ll[i,"remove"] <- 1
}

shp_simp_ll <- shp_simp_ll %>% 
  filter(remove == 0)

# Write GeoJSON (UTF-8)
st_write(shp_simp_ll, 
         "/Users/akashbanerjee/Desktop/1_Projects/interactive_zcta_map/zcta.geojson", 
         driver = "GeoJSON", delete_dsn = TRUE)
