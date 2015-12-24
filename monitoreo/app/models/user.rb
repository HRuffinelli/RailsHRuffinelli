class User < ActiveRecord::Base
  validates :name, presence: true
  validates :lastname, presence: true
  validates :alias, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }

  has_many :alerts
  has_many :rules, :through => :alerts
end
