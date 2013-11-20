class Engine < ActiveRecord::Base

  # Association
  belongs_to :enginestatus
  validates :serialno, :presence => true,
                       :uniqueness =>{:scope => :engineModelName }

end
