class Server < ActiveRecord::Base
  has_many :infos
  validates :name, presence: true
  validates :ip, presence: true, length: { minimum: 7 }
  validates :dns, presence: true, length: { minimum: 5 }
end
