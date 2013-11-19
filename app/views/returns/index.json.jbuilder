json.array!(@returns) do |return|
  json.extract! return, :returnDate, :returnComment, :sendingComment
  json.url return_url(return, format: :json)
end
