json.array!(@repairorders) do |repairorder|
  json.extract! repairorder, :issueNo, :issueDate, :orderNo, :constructionNo, :otherBrandPartsArrivealDate, :returnDate, :returningComment, :sendingComment
  json.url repairorder_url(repairorder, format: :json)
end
