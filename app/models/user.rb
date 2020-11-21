class User < ApplicationRecord
  attr_accessor :login

  # Scope
  scope :search_by_name_or_email, ->(search) { where 'firstname ILIKE :search_query OR lastname ILIKE :search_query OR username ILIKE :search_query OR phone_no ILIKE :search_query OR email ILIKE :search_query', search_query: search.downcase }

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :async, authentication_keys: [:login]

  has_one_attached :image
  has_many :apartments
  has_many :subscriptions
  has_many :bookings
  has_many :invoices, through: :subscriptions
  validates :terms_of_service, acceptance: true
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

  # display user's available apartments
  def available_apartments
    apartments.where(availability: false)
  end

  # Get the total subscribed/Live apartments
  def subscribed_apartment
    apartments.select(&:subscribed)
  end

  # Get the total Unsubscribed/Pending apartments
  def unsubscribed_apartment
    apartments.reject(&:subscribed)
  end

  # Get the total Available apartments
  def available_apartments
    apartments.select(&:availability)
  end

  # Get the total Booked apartments
  def unavailable_apartments
    apartments.reject(&:availability)
  end
end
