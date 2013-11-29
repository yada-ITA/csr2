class Engineorder < ActiveRecord::Base
 #引合の登録かどうか？
 def registInquiry?
   return true if businessstatus_id.nil?
 end 

  #現時点での発行Noの生成 (年月-枝番3桁)
  def self.createIssueNo
    issuedate = Date.today.strftime("%Y%m") 
    maxseq = self.where("issueno like ?", issuedate + "%").max()
    issueseq = '001'

   unless maxseq.nil?
    issueseq = sprintf("%03d", maxseq.issueNo.split('-')[1].to_i + 1)
   end

    return issuedate + "-" + issueseq

  end

  #流通ステータスに「引合」をセットする
  def setInquiry
    self.businessstatus_id = 1
  end

  #流通ステータスに「受注」をセットする
  def setOrdered
    self.businessstatus_id = 2
  end
end
