class EsiGroup < ActiveRecord::Base
  validates_presence_of :esi_group_name, :address, :esi_no
  validates_uniqueness_of :esi_group_name

  has_many :branches
end