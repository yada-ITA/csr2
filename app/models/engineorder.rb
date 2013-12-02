class Engineorder < ActiveRecord::Base
  #Association
  belongs_to :old_engine, :class_name => 'Engine' 
  belongs_to :new_engine, :class_name => 'Engine' 

  belongs_to :branch, :class_name => 'Company' 
  belongs_to :install_place, :class_name => 'Company' 
  belongs_to :sending_place, :class_name => 'Company' 

  belongs_to :registered_user, :class_name => 'User' 
  belongs_to :updated_user, :class_name => 'User' 
  belongs_to :salesman, :class_name => 'User' 


 #引合の登録かどうか？
 def registInquiry?
   return true if businessstatus_id.nil?
 end 

  #現時点での発行Noの生成(年月-枝番3桁)
  def self.createIssueNo
    issuedate = Date.today.strftime("%Y%m") 
    maxseq = Engineorder.where("issue_no like ?", issuedate + "%").max()
    issueseq = '001'

   unless maxseq.nil?
    issueseq = sprintf("%03d", maxseq.issue_no.split('-')[1].to_i + 1)
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
