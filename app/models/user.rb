class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :firstname, :lastname, :birthdate, :address, :gender
  validates :phone_no, :presence => true,
                       :numericality => true,
                       :length => { :minimum => 10, :maximum => 12 }
end
