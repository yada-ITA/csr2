class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Association
  belongs_to :company
  
  # validation checks
  validates :userid, :presence => true,
                     :uniqueness => true,
                     :length => { :is => 8 },
                     :format => { :with => /[A-Za-z][A-Za-z][0-9][0-9][0-9][0-9][0-9][0-9]/}
  
  validates :name, :presence => true

  validates :email, :presence => true

end
