class Repair < ActiveRecord::Base

  # validation
  
  # Association
  belongs_to :engine
  
  # ì‹Æ’†‚©‚Ç‚¤‚©‚ð”»’è‚·‚é
  def opened?
    return self.finish_date.nil?
  end

  # Œ»Žž“_‚Å‚Ì”­sNo‚Ì¶¬(”NŒŽ-Ž}”Ô3Œ…)
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
