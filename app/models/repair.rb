class Repair < ActiveRecord::Base

  # validation
  
  # Association
  belongs_to :engine
  
  # ì‹Æ’†‚©‚Ç‚¤‚©‚ð”»’è‚·‚é
  def opened?
    return self.finishDate.nil?
  end

  # Œ»Žž“_‚Å‚Ì”­sNo‚Ì¶¬(”NŒŽ-Ž}”Ô3Œ…)
  def self.createIssueNo
    issuedate = Date.today.strftime("%Y%m") 
    return issuedate + "-" + 
           sprintf("%03d", self.where("issueNo like ?", issuedate + "%").max() + 1 )
  end
  
end
