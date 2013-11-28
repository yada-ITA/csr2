class Engine < ActiveRecord::Base

  # Association
  belongs_to :enginestatus
  belongs_to :company
  
  has_many :repairs
  
  # Validation
  validates :engineModelName, :presence => true  
  validates :serialno, :presence => true,
                       :uniqueness =>{:scope => :engineModelName }
  
  # Get unclosed repair
  def current_repair
    if !(repairs.blank?)
      repairs.each do | repair |
        if repair.opened?
         return repair
        end
      end
    end
    return nil
  end
  
end
