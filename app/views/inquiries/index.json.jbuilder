json.array!(@inquiries) do |inquiry|
  json.extract! inquiry, :loginUserId, :branchCode, :userId, :placeCode, :orderer, :machineNo, :timeOfRunning, :dayOfTest, :changeComment
  json.url inquiry_url(inquiry, format: :json)
end
