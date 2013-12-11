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

  # 仕掛中かどうかを確認する
  def opened?
    return self.returning_date.nil?
  end

  # ステータスの確認メソッド集 --------------- #
  # 新規引合かどうか？
  def registInquiry?
    return true if self.businessstatus_id.nil?
  end 

  #引合かどうか？
  def isInquiry?
    return true if self.businessstatus_id.to_i == 1 
  end 

  #受注かどうか？
  def isOrdered?
    return true if self.businessstatus_id.to_i == 2 
  end 

  #出荷準備中かどうか？
  def isShippingreparation?
    return true if self.businessstatus_id.to_i == 3 
  end 

  #出荷済かどうか？
  def isShipped?
    return true if self.businessstatus_id.to_i == 4 
  end 
  #返却済みかどうか？
  def isReturned?
    return true if self.businessstatus_id.to_i == 5 
  end 

  #キャンセルかどうか？
  def isCanceled?
    return true if self.businessstatus_id.to_i == 9 
  end 

  # 旧エンジンに対する整備オブジェクトを取り出す
  def repair_for_old_engine
    return old_engine.current_repair
  end

  # 新エンジンに対する整備オブジェクトを取り出す
  def repair_for_new_engine
    return new_engine.current_repair
  end

  # ステータスの変更メソッド集 --------------- #
  # 流通ステータスに「引合」をセットする
  def setInquiry
    self.businessstatus_id = 1
  end

  # 流通ステータスに「受注」をセットする
  def setOrdered
    self.businessstatus_id = 2
  end

  # 流通ステータスに「出荷準備中」をセットする
  def setShippingreparation
    self.businessstatus_id = 3
  end

  # 流通ステータスに「出荷済み」をセットする
  def setShipped
    self.businessstatus_id = 4
  end

  #流通ステータスに「返却済み」をセットする
  def setReturned
    self.businessstatus_id = 5
  end

  #流通ステータスに「キャンセル」をセットする
  def setCanceled
    self.businessstatus_id = 9
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


  #試運転日から運転年数を求める。(運転年数は、切り上げ)
  def calcRunningYear
    return  ((Date.today - self.day_of_test)/365).ceil unless self.day_of_test.nil? 
  end

  def createRepair
    # 整備オブジェクトを受領前の状態で新規作成して返す
    repair = Repair.new
    repair.issue_no          = Repair.createIssueNo
    repair.issue_date        = self.order_date
    repair.time_of_running   = self.time_of_running
    repair.day_of_test       = self.day_of_test
    
    # 整備オブジェクトに旧エンジンを紐づける
    repair.engine            = self.old_engine
    
    return repair
  end

end