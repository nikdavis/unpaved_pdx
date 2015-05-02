require 'json'

def latlon_to_meters(lat1, lon1, lat2, lon2)
    r = 6378.137 # Radius of earth in KM
    #puts lat2.class
    #puts lat1.class
    dLat = (lat2 - lat1) * Math::PI / 180
    dLon = (lon2 - lon1) * Math::PI / 180
    a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) * Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = r * c
    return d * 1000 # meters
end

str = File.read("only_gravel.geojson")
obj = JSON.parse(str)["features"]
obj = obj.select {|o| o["geometry"]["type"] == "LineString" && o["geometry"]["coordinates"].length == 2}

dist = obj.inject(0) do |sum, o|
  coords = o["geometry"]["coordinates"]
  sum + latlon_to_meters(coords[0][1],coords[0][0],coords[1][1],coords[1][0])
end

puts "At least #{(dist * 0.000621371).round(1)} miles" # miles