library(sf)
library(dplyr)

# ZCTAs in Philadelphia County
zctas <- c(19106, 19102, 19125, 19130, 19103, 19104, 19107, 
           19108, 19109, 19118, 19119, 19120, 19121, 19122, 
           19123, 19124, 19126, 19127, 19128, 19129, 19131, 
           19132, 19133, 19134, 19135, 19136, 19137, 19138, 
           19139, 19140, 19141, 19142, 19143, 19144, 19145, 
           19146, 19147, 19148, 19149, 19150, 19151, 19152, 
           19153, 19154, 19155, 19244, 19161)

# adjust path to your shapefile folder
shp <- st_read("/Users/akashbanerjee/Downloads/nhgis0084_shape/nhgis0084_shapefile_tl2020_us_zcta_2020/US_zcta_2020.shp") %>% 
  filter(GEOID20 %in% zctas)

# reproject to WGS84 lon/lat
shp_ll <- st_transform(shp, 4326)

# Write GeoJSON (UTF-8)
st_write(shp_ll, 
         "/Users/akashbanerjee/Desktop/1_Projects/interactive_zcta_map/zcta.geojson", 
         driver = "GeoJSON", delete_dsn = TRUE)

# Simplify geometry for web (tolerance in map units; tune as needed)
shp_simp_ll <- st_simplify(st_make_valid(shp_ll), 
                           dTolerance = 10000)

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
