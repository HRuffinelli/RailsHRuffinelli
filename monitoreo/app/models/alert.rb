class Alert < ActiveRecord::Base
  belongs_to :user
  belongs_to :rule
  
  validates_uniqueness_of :user_id, :scope => :rule_id
end
