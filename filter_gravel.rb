require 'json'

str = File.read("roads.geojson")
obj = JSON.parse(str)

puts "This GeoJSON has #{obj["features"].length} features."
#surfacetypes = obj["features"].collect {|o| o["properties"]["SURFACETYP"]}
#puts surfacetypes.uniq
unpaved = obj["features"].select {|o| o["properties"]["SURFACETYP"] == "GRAVEL"}
puts "of which #{unpaved.length} are gravel!"

obj["features"] = unpaved

output = File.open("only_gravel.geojson", "w")
output << obj.to_json
output.close

