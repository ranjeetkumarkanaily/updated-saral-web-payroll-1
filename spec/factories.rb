# By using the symbol ':employee', we get Factory Girl to simulate the Employee model.
FactoryGirl.define do
  factory :employee do
    refno 1001
    email "test@test.com"
    present_state_id "1"
    empname "XYZ"
    date_of_joining "2011-02-01"
    date_of_leaving ""
    department
    designation
    grade
  end

  factory :lop do
    employee
    month_year "Jan/2011"
    lop 1
  end

  factory :salary_head do
    head_name "Basic"
    short_name "BASIC"
    salary_type "Earnings"
  end

 factory :salary_allotment do
    employee_id 1
    employee_detail_id 1
    effective_date '2011-02-01'
    salary_head
    salary_allotment 1000.00
  end

  factory :salary do
    effective_date '2011-02-01'
    salary_amount 1000.00
    employee_id 1
    employee_detail_id 1
    salary_head
  end

  factory :salary_group_detail do
    salary_group_id 1
    salary_head
    calc_type 'Lumpsum'
    calculation ""
    based_on "PayDays"
  end

  factory :employee_detail do
    employee_id  1
    effective_date "2009-10-31"
    salary_group_id 1
    allotted_gross 5000
  end

  factory :state do
    state_name "XYZ"
  end

  factory :leave_detail do
    employee
    leave_date '2011-01-01'
  end

  factory :department do
    department 'WDO'
  end

  factory :designation do
    designation 'Manager'
  end

  factory :grade do
    grade 'First'
  end



end
