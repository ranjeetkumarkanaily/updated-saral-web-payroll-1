class EmployeeDetail < ActiveRecord::Base

  belongs_to :employee
  belongs_to :salary_group
  has_many :salary_allotments, :dependent => :destroy
end