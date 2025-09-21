library(sf)

# adjust path to your shapefile folder
shp <- st_read("/Users/akashbanerjee/Downloads/nhgis0084_shape/nhgis0084_shapefile_tl2020_us_zcta_2020/US_zcta_2020.shp")   # reads shapefile

# reproject to WGS84 lon/lat
shp_ll <- st_transform(shp_simp, 4326)

# Simplify geometry for web (tolerance in map units; tune as needed)
shp_simp_ll <- st_simplify(shp_ll, dTolerance = 3000)

# Make sure GEOID20 is a string (important)
shp_simp_ll$GEOID20 <- as.character(shp_simp_ll$GEOID20)

# Write GeoJSON (UTF-8)
st_write(shp_simp_ll, 
         "/Users/akashbanerjee/Desktop/1_Projects/interactive_zcta_map/zcta.geojson", 
         driver = "GeoJSON", delete_dsn = TRUE)
