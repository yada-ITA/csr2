json.array!(@locations) do |location|
  json.extract! location, :postcode, :address, :phoneNo, :destinationName
  json.url location_url(location, format: :json)
end
