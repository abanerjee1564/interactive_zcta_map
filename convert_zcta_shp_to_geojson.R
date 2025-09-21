library(sf)

# adjust path to your shapefile folder
shp <- st_read("/Users/akashbanerjee/Desktop/1_Projects/interactive_map/US_zcta_2020.shp")   # reads shapefile

# Optional: simplify geometry for web (tolerance in map units; tune as needed)
shp_simp <- st_simplify(shp, dTolerance = 100) # reduce complexity (tolerance depends on unit)

# Make sure GEOID20 is a string (important)
shp_simp$GEOID20 <- as.character(shp_simp$GEOID20)

# Write GeoJSON (UTF-8)
st_write(shp_simp, "zcta.geojson", driver = "GeoJSON", delete_dsn = TRUE)
