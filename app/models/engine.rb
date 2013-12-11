class Engine < ActiveRecord::Base

  # Association
  belongs_to :enginestatus
  belongs_to :company
  
  has_many :repairs
  has_many :engineorders_as_new, :class_name => :engine, :foreign_key => 'new_engine_id'
  has_many :engineorders_as_old, :class_name => :engine, :foreign_key => 'old_engine_id'
  
  # Validation
  validates :engine_model_name, :presence => true  
  validates :serialno, :presence => true,
                       :uniqueness =>{:scope => :engine_model_name }
  
  # Get current repair (get unclosed one)
  # 現在作業中の整備オブジェクトを返す
  def current_repair
    if !(repairs.blank?)
      repairs.each do | repair |
        if repair.opened?
         return repair
        end
      end
    end
    return nil
  end

  # Get unclosed order (this engine is old engine for it and it is not unclosed)
  # 旧エンジンとして関わっている受注オブジェクトのうち、現在仕掛中のものを返す
  def current_order_as_old
    if !(engineorders_as_old.blank?)
      engineorders_as_old.each do | order |
        if order.opened?
         return order
        end
      end
    end
    return nil
  end
  
  # Get unclosed order (this engine is new engine for it and it is not unclosed)
  # 新エンジンとして関わっている受注オブジェクトのうち、現在仕掛中のものを返す
  def current_order_as_new
    if !(engineorders_as_new.blank?)
      engineorders_as_new.each do | order |
        if order.opened?
         return order
        end
      end
    end
    return nil
  end

  #エンジン型式とシリアルNoを併せてエンジン名として表示する。
  def engine_name
    "#{engine_model_name} ( #{serialno} )"
  end

  #完成品のエンジン一覧を取得する。
  def self.completedEngines
     return Engine.where(:enginestatus_id => 3)
  end

  # ステータスを受領前にする
  def setBeforeArrive
     self.enginestatus_id = 1
  end 
  # ステータスを整備前にする
  def setBeforeRepair
     self.enginestatus_id = 2
  end 
  # ステータスを整備中にする
  def setUnderRepair
     self.enginestatus_id = 3
  end 

  # ステータスを完成品にする
  def setCompleted
     self.enginestatus_id = 4
  end 

  # ステータスを出荷準備中にする
  def setBeforeShipping
     self.enginestatus_id = 5
  end 

  # ステータスを出荷済にする
  def setAfterShipping
     self.enginestatus_id = 6
  end 

  # ステータスを廃棄済にする
    def setAbolishment
     self.enginestatus_id = 7
  end 

  # 受領前状態かどうか？
  def beforeArrive?
    return self.enginestatus_id.to_i == 1 
  end 

  # 整備前状態かどうか？
  def beforeRepair?
    return self.enginestatus_id.to_i == 2 
  end 

  # 整備中状態かどうか？
  def underRepair?
    return self.enginestatus_id.to_i == 3 
  end 

  # 完成品状態かどうか？
  def completed?
    return self.enginestatus_id.to_i == 4 
  end 

  # 出荷準備中状態かどうか？
  def beforeShipping?
    return self.enginestatus_id.to_i == 5 
  end 
  
  # 出荷済状態かどうか？
  def afterShipped?
    return self.enginestatus_id.to_i == 6 
  end 

  # 廃却状態かどうか？
  def abolished?
    return self.enginestatus_id.to_i == 7 
  end 

end
