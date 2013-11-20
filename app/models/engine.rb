class Engine < ActiveRecord::Base

  # Association
  belongs_to :enginestatus
  belongs_to :company
  
  has_many :repairs
  has_many :repairordrs  
  
  # Validation
  validates :engineModelName, :presence => true  
  validates :serialno, :presence => true,
                       :uniqueness =>{:scope => :engineModelName }
end
