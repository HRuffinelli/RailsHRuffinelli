class Rule < ActiveRecord::Base
  has_many :alerts
  has_many :users, :through => :alerts
  
  validates :name, presence: true, uniqueness: true
  validates :priority, presence: true, uniqueness: true, :length => { :within => 1..20 }
  validates :cpuchargeexceed, presence: true
  validates :diskspaceexceed, presence: true
  validates :timeexceed, presence: true
end
