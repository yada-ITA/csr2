class Engineorder < ActiveRecord::Base
  #Association
  belongs_to :businessstatus

  belongs_to :old_engine, :class_name => 'Engine' 
  belongs_to :new_engine, :class_name => 'Engine' 

  belongs_to :branch, :class_name => 'Company' 
  belongs_to :install_place, :class_name => 'Company' 
  belongs_to :sending_place, :class_name => 'Company' 

  belongs_to :registered_user, :class_name => 'User' 
  belongs_to :updated_user, :class_name => 'User' 
  belongs_to :salesman, :class_name => 'User' 


  #新規引合かどうか？
  def registInquiry?
    return true if self.businessstatus_id.nil?
  end 

  #引合以降かどうか？
  def afterInquiry?
    return true if self.businessstatus_id.to_i >= 1 
  end 

  #受注以降かどうか？
  def afterOrdered?
    return true if self.businessstatus_id.to_i >= 2 
  end 

  #引当登録以降かどうか？
  def afterAccepted?
    return true if self.businessstatus_id.to_i >= 3 
  end 

  #出荷登録以降かどうか？
  def afterShipped?
    return true if self.businessstatus_id.to_i >= 4 
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

  #流通ステータスに「出荷済み」をセットする
  def setShipped
    self.businessstatus_id = 4
  end

  def createRepair
    # 整備オブジェクトを受領前の状態で新規作成して返す
    repair = Repair.new
    repair.issue_no          = Repair.createIssueNo
    repair.issue_date        = self.order_date         # 暫定で受注日をセット
    repair.time_of_running   = self.time_of_running
    # @repair.day_of_test       = self.day_of_test        # 試運転日が無い！
    # @repair.returning_comment = self.returning_comment  # 引当画面に返却コメントが必要
    # 整備オブジェクトに旧エンジンを紐づける
    repair.engine            = self.old_engine
    repair.engine.enginestatus_id = 1
    # 整備オブジェクトの会社として、拠点コードを紐づける
    repair.engine.company    = self.branch             # 暫定で拠点をセット
    return repair
  end

end