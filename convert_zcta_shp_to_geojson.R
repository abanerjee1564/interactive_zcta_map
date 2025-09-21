library(sf)

# adjust path to your shapefile folder
shp <- st_read("/Users/akashbanerjee/Downloads/nhgis0084_shape/nhgis0084_shapefile_tl2020_us_zcta_2020/US_zcta_2020.shp")   # reads shapefile

# Optional: simplify geometry for web (tolerance in map units; tune as needed)
shp_simp <- st_simplify(shp, dTolerance = 300) # reduce complexity (tolerance depends on unit)

# Make sure GEOID20 is a string (important)
shp_simp$GEOID20 <- as.character(shp_simp$GEOID20)

# Write GeoJSON (UTF-8)
st_write(shp_simp, "/Users/akashbanerjee/Desktop/1_Projects/interactive_zcta_map/zcta.geojson", driver = "GeoJSON", delete_dsn = TRUE)
