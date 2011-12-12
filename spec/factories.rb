# By using the symbol ':employee', we get Factory Girl to simulate the Employee model.
FactoryGirl.define do
  factory :employee do
    empname "XYZ"
    date_of_joining "2011-02-01"
    date_of_leaving ""
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
    salary_amount 1000
    employee_id 1
    employee_detail_id 1
    salary_head_id 1
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
end