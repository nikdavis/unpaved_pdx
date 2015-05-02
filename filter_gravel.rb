require 'json'

str = File.read("unpaved.geojson")
obj = JSON.parse(str)

puts "This GeoJSON has #{obj["features"].length} features."
unpaved = obj["features"].select {|o| o["properties"]["SURFACETYP"] == "GRAVEL"}
puts "of which #{unpaved.length} are gravel!"

obj["features"] = unpaved

output = File.open("only_gravel.geojson", "w")
output << obj.to_json
output.close

