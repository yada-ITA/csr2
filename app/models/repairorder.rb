class Repairorder < ActiveRecord::Base

  # Association
  belongs_to :engine

  #現時点での発行Noの生成(年月-枝番3桁)
  def self.createIssueNo
    issuedate = Date.today.strftime("%Y%m") 
    return issuedate + "-" + 
           sprintf("%03d", self.where("issueNo like ?", issuedate + "%").max() + 1 )
  end

end
