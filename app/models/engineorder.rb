class Engineorder < ActiveRecord::Base
  #Association
  belongs_to :businessstatus

  belongs_to :old_engine, :class_name => 'Engine' ,:autosave => 'true'
  belongs_to :new_engine, :class_name => 'Engine' ,:autosave => 'true'

  belongs_to :branch, :class_name => 'Company' 
  belongs_to :install_place, :class_name => 'Company' 
  belongs_to :sending_place, :class_name => 'Company' 

  belongs_to :registered_user, :class_name => 'User' 
  belongs_to :updated_user, :class_name => 'User' 
  belongs_to :salesman, :class_name => 'User' 


  #引合の登録かどうか？
  def registInquiry?
    return true if self.businessstatus_id.nil?
  end 

  #引当登録かどうか？
  def registAccepted?
    return true if self.businessstatus_id.to_i == 3 
  end 

  #引当登録以降かどうか？
  def afterAccepted?
    return true if self.businessstatus_id.to_i >= 3 
  end 

  #現時点での発行Noの生成 (年月-枝番3桁)
  def self.createIssueNo
    issuedate = Date.today.strftime("%Y%m") 
    maxseq = self.where("issue_no like ?", issuedate + "%").max()
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

  #流通ステータスに「出荷準備中」をセットする
  def setAllocated
    self.businessstatus_id = 3
  end

end