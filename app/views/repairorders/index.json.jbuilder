json.array!(@repairorders) do |repairorder|
  json.extract! repairorder, :issueNo, :inquiryDate, :loginUserId, :branchCode, :userId, :placeCode, :orderer, :machineNo, :timeOfRunning, :changeComment, :sendingCompanyCode, :sendingComment, :deliveryDate, :businessstatus_id
  json.url repairorder_url(repairorder, format: :json)
end
