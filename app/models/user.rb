class User < ApplicationRecord
  attr_accessor :login

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :async, authentication_keys: [:login]

  has_one_attached :image
  has_many :apartments
  has_many :subscriptions
  has_many :bookings
  validates_presence_of :firstname, :lastname
  validates :username, presence: true, uniqueness: true
  validates :phone_no, presence: true,
                       numericality: true,
                       length: { minimum: 10, maximum: 12 }

  # Devise Authentication using Username or Email Query
  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ['lower(username) = :value OR lower(email) = :value', { value: login.strip.downcase }]
    ).first
  end

  # Check if user has administrative role
  def administrative_role?
    has_any_role? :admin, :landlord
  end

  # Check if user has student role
  def student?
    has_role? :student
  end

  # Check if user has admin role
  def admin?
    has_role? :admin
  end

  # Check if user has landlord role
  def landlord?
    has_role? :landlord
  end

  # User full name
  def fullname
    "#{firstname} #{lastname}"
  end
end
