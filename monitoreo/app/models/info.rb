class Info < ActiveRecord::Base
  belongs_to :server
  
  validates :server_id, presence: true
  validates :cpucharge, presence: true
  validates :diskspace, presence: true
end
