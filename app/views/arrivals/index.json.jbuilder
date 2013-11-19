json.array!(@arrivals) do |arrival|
  json.extract! arrival, :arrivalDate, :arrivalComment
  json.url arrival_url(arrival, format: :json)
end
