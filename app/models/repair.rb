class Repair < ActiveRecord::Base

  # virtual attribute
  attr_accessor :returning_comment, :returning_date 
  
  # validation
  
  # Association
  belongs_to :engine

  # getter and setter for virtual attribute
  def returning_date
    unless self.engine.current_order.nil?  
      return self.engine.current_order.returning_date
    end
    return nil
  end
  def returning_date=(returning_date_value)
    unless self.engine.current_order.nil? 
      self.engine.current_order.returning_date = returning_date_value
    end
  end

  def returning_comment
    unless self.engine.current_order.nil?
      return self.engine.current_order.returning_comment
    end
    return nil
  end
  def returning_comment=(returning_comment_value)
    unless self.engine.current_order.nil? 
      self.engine.current_order.returning_comment = returning_comment_value
    end
  end

  
  # 作業中かどうかを判定する
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

  
end
