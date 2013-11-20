class Engine < ActiveRecord::Base

  # Association
  belongs_to :enginestatus
  validates :engineModelName, :presence => true  
  validates :serialno, :presence => true,
                       :uniqueness =>{:scope => :engineModelName }

end
