class User < ActiveRecord::Base
has_many :ratings, :dependent => :destroy
has_many :memberships, :dependent => :destroy
has_many :beers, through: :ratings
has_many :beer_clubs, through: :memberships

include Average

has_secure_password

validates :username, uniqueness: true
validates :username, length: { in: 3..15 }
validates :password, length: { minimum: 4 }
validates :password, format: { with: /(.*[A-Z].*[0-9].*)|(.*[0-9].*[A-Z].*)/ }
validates_confirmation_of :password
  attr_accessible :username, :password, :password_confirmation
end
