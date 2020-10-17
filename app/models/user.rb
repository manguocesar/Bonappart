class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  validates_presence_of :firstname, :lastname, :birthdate, :address, :gender
  validates :phone_no, presence: true,
                       numericality: true,
                       length: { minimum: 10, maximum: 12 }

  # Check if user has administrative role
  def administrative_role?
    (has_role? :admin) || (has_role? :landlord)
  end

  # Check if user has student role
  def student_role?
    (has_role? :student)
  end
end
