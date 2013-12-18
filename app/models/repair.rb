class Repair < ActiveRecord::Base

  # validation
  
  # Association
  belongs_to :engine
  
  # エンジンをセットする
  def setEngine(engine)
    if self.engine.nil?
      self.engine = engine
    else
      unless self.engine == engine
        prev_engine = self.engine
        prev_engine.suspend
        prev_engine.save
        self.engine = engine
      end
    end
  end

  # getter and setter for virtual attribute
  # 返却日
  def returning_date
    unless self.engine.current_order_as_old.nil?
      return self.engine.current_order_as_old.returning_date
    end
    return nil
  end
  def returning_date=(returning_date_value)
    #新規作成時はself.engineがnilなので、いったん確認する。
    #(nilに対してcurrent_order_oldは確認できない…)
    unless self.engine.nil?
      unless self.engine.current_order_as_old.nil? 
        self.engine.current_order_as_old.returning_date = returning_date_value
      end
    end
  end

  # getter and setter for virtual attribute
  # 返却コメント
  def returning_comment
    unless self.engine.current_order_as_old.nil?
      return self.engine.current_order_as_old.returning_comment
    end
    return nil
  end
  def returning_comment=(returning_comment_value)
    #新規作成時はself.engineがnilなので、いったん確認する。
    #(nilに対してcurrent_order_oldは確認できない…)
    unless self.engine.nil?
      unless self.engine.current_order_as_old.nil? 
        self.engine.current_order_as_old.returning_comment = returning_comment_value
      end
    end
  end

  
  # 作業中かどうかを判定する（出荷日が入っていたら”終了した整備”と解釈）
  def opened?
    return self.shipped_date.nil?
  end

  # 現時点での発行Noの生成(年月-枝番3桁)
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

end
