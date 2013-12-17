#coding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Association
  belongs_to :company
  has_many :engineorders
  
  # validation checks
  validates :userid, :presence => true,
                     :uniqueness => true,
                     :length => { :is => 8 },
                     :format => { :with => /[A-Za-z][A-Za-z][0-9][0-9][0-9][0-9][0-9][0-9]/}
  
  validates :name, :presence => true

  validates :email, :presence => true

#現在ログインしているユーザーがYES本社の人かどうか
def yesOffice?
  if Company.find(self.company_id).category == "YES本社"
    return true      
  else
    return false
  end
end

#現在ログインしているユーザーがYES拠点の人かどうか
def yesBranch?
  if Company.find(self.company_id).category == "YES拠点"
    return true      
  else
    return false
  end
end

#現在ログインしているユーザーが整備会社の人かどうか
def tender?
  if Company.find(self.company_id).category == "整備会社"
    return true      
  else
    return false
  end
end

end
