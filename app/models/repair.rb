class Repair < ActiveRecord::Base

  # validation
  
  # Association
  belongs_to :engine
  
  # 作業中かどうかを判定する
  def opened?
    return self.finish_date.nil?
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
