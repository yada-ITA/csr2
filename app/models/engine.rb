class Engine < ActiveRecord::Base

  # Association
  belongs_to :enginestatus
  belongs_to :company
  validates :engineModelName, :presence => true  
  validates :serialno, :presence => true,
                       :uniqueness =>{:scope => :engineModelName }
end
