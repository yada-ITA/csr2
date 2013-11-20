json.array!(@returnings) do |returning|
  json.extract! returning, :returnDate, :returningComment, :sendingComment
  json.url returning_url(returning, format: :json)
end
