class Repair < ActiveRecord::Base

  # validation
  
  # Association
  belongs_to :engine
  
  def opened?
    return self.finishDate.nil?
  end
  
end
