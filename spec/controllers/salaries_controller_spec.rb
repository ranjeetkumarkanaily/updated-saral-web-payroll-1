require 'spec_helper'
describe SalariesController do
  before :each do
    controller.stub(:logged_in?).and_return(true)
  end

  describe "POST create" do
    describe "Creation of new Salary" do

      before :each do
        @salary_head = FactoryGirl.create(:salary_head)
        @salary_group_detail = FactoryGirl.create(:salary_group_detail, :salary_head_id => @salary_head.id)
        @attendance_configuration = FactoryGirl.create(:attendance_configuration)
        @financial_institution = FactoryGirl.create(:financial_institution)
        pf_group = FactoryGirl.create(:pf_group)
        @pay_month =  FactoryGirl.create(:paymonth, :month_year => 24134, :number_of_days => 28,:from_date => "2011-02-01",:to_date => "2011-02-28",:month_name => "Feb/2011")
        esi_group = FactoryGirl.create(:esi_group)
        @branch = FactoryGirl.create(:branch,:pf_group_id => pf_group.id, :esi_group_id => esi_group.id)

        pf_group_rate = FactoryGirl.create(:pf_group_rate,:pf_group_id => pf_group.id, :paymonth_id => @pay_month.id)
        esi_group_rate = FactoryGirl.create(:esi_group_rate,:esi_group_id => esi_group.id)
      end

      it "Count should be increases by one" do
        employee = FactoryGirl.create(:employee)
        employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => @attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => @financial_institution.id)
        leave_definition = FactoryGirl.create(:leave_definition)
        leave_detail = FactoryGirl.create(:leave_detail,:leave_date => "2011-02-02", :employee_id => employee.id,:leave_definition_id=>leave_definition.id)
        salary = FactoryGirl.build(:salary,:employee_id => employee.id, :salary_head_id => @salary_head.id, :salary_group_detail_id => @salary_group_detail.id)
        expect {
          post :create, :salary => [salary.attributes],:month_year=>'Feb/2011'
        }.to change(Salary, :count).by(3)
      end

      it "redirects to salary index path" do
        employee = FactoryGirl.create(:employee)
        employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => @attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => @financial_institution.id)
        leave_definition = FactoryGirl.create(:leave_definition)
        leave_detail = FactoryGirl.create(:leave_detail,:leave_date => "2011-02-02", :employee_id => employee.id,:leave_definition_id=>leave_definition.id)
        salary = FactoryGirl.build(:salary,:employee_id => employee.id, :salary_head_id => @salary_head.id, :salary_group_detail_id => @salary_group_detail.id)
        post :create, :salary => [salary.attributes],:month_year=>'Feb/2011'
        response.should redirect_to salaries_path
      end
    end
  end

  describe "GET new" do
    it "assigns a requested SalaryAllotment as @SalaryAllotment" do
      employee = FactoryGirl.create(:employee)
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=>salary_head.id)
      sal_allot = FactoryGirl.create(:salary_allotment,:salary_group_detail_id=>salary_group_detail.id, :employee_id => employee.id,:salary_head_id=>salary_head.id)
      get :new, :month_year => "Feb/2011", :employee_id => sal_allot.employee_id
      assigns(:salary_allotments).should eq([sal_allot])
    end

    it "assigns a requested SalaryAllotment as @SalaryAllotment" do
      employee = FactoryGirl.create(:employee)
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=>salary_head.id)
      sal_allot = FactoryGirl.create(:salary_allotment,:salary_group_detail_id=>salary_group_detail.id, :employee_id => employee.id,:salary_head_id=>salary_head.id)
      get :new, :month_year => "Mar/2011", :employee_id => sal_allot.employee_id
      assigns(:salary_allotments).should eq([sal_allot])
    end

    it "should redirect to new salary page if selected employee is already leave the company" do
      employee = FactoryGirl.create(:employee,:date_of_leaving => "2011-02-28",:leaving_reason => 'Without Reason')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=>salary_head.id)
      sal_allot = FactoryGirl.create(:salary_allotment,:salary_group_detail_id=>salary_group_detail.id, :employee_id => employee.id,:salary_head_id=>salary_head.id)
      get :new, :month_year => "Mar/2011", :employee_id => sal_allot.employee_id
      response.should redirect_to new_salary_path
    end
  end

  describe "GET index" do
    before :each do
      paymonth = FactoryGirl.create(:paymonth, :month_year =>24134, :number_of_days => 28, :from_date =>"2011-02-01",:to_date => "2011-02-28", :month_name => "Feb/2011")
      @pt_group = FactoryGirl.create(:pt_group)
      @branch = FactoryGirl.create(:branch,:pt_group_id => @pt_group.id)
      pt_rate = FactoryGirl.create(:pt_rate, :paymonth_id => paymonth.id, :pt_group_id => @pt_group.id)
    end

    it "get salary earnings for the given employee" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee)
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      employee_statutory = FactoryGirl.create(:employee_statutory, :employee_id => employee.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :index, :month_year => "Feb/2011", :employee_id => salary.employee_id
      assigns(:salary_earning)[0].salary_amount.should eq(salary.salary_amount)
    end

    it "get salary deductions for the given employee" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee)
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      employee_statutory = FactoryGirl.create(:employee_statutory, :employee_id => employee.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head,:salary_type => "Deductions")
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :index, :month_year => "Feb/2011", :employee_id => salary.employee_id
      assigns(:salary_deduction)[0].salary_amount.should eq(salary.salary_amount)
    end

    it "generates pdf output" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee)
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      employee_statutory = FactoryGirl.create(:employee_statutory, :employee_id => employee.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :index, :month_year => "Feb/2011", :employee_id => salary.employee_id, :format => "pdf"
      response.should render_template('salaries/index')
    end

    it "sends email to user" do
      company = FactoryGirl.create(:company,:photo => Rails.root.join("spec/factories/icon_a.png").open)
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee)
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      employee_statutory = FactoryGirl.create(:employee_statutory, :employee_id => employee.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :index, :month_year => "Feb/2011", :employee_id => salary.employee_id,:email => "yes", :format => "pdf"
      response.should render_template('salaries/index')
    end

    it "should give no of present days" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee)
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      employee_statutory = FactoryGirl.create(:employee_statutory, :employee_id => employee.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :index, :month_year => "Feb/2011", :employee_id => employee.id
      assigns(:no_of_present_days).should eq(28)
    end

    it "should give no of present days" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee,:date_of_leaving => "2011-02-15",:leaving_reason => 'Without Reason')
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      employee_statutory = FactoryGirl.create(:employee_statutory, :employee_id => employee.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :index, :month_year => "Feb/2011", :employee_id => employee.id
      assigns(:no_of_present_days).should eq(15)
    end
  end
  describe "Update" do
    it "should update the salary amount" do
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      sal = FactoryGirl.create(:salary, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      post :update, :id => sal.id, :salary => [sal.attributes.merge(:salary_amount => 1000)]
      Salary.find_by_id(sal.id)[:salary_amount].should eq(1000)
    end
  end

  describe "GET edit" do
    it "assigns the requested Salary as @salary" do
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      get :edit, :month_year => "Feb/2011", :employee_id => 1
      assigns(:salary).should eq([salary])
    end
  end

  describe "Salary Sheet" do
    before :each do
      paymonth = FactoryGirl.create(:paymonth, :month_year =>24134, :number_of_days => 28, :from_date =>"2011-02-01",:to_date => "2011-02-28", :month_name => "Feb/2011")
      @pt_group = FactoryGirl.create(:pt_group)
      @branch = FactoryGirl.create(:branch,:pt_group_id => @pt_group.id)
      pt_rate = FactoryGirl.create(:pt_rate, :paymonth_id => paymonth.id, :pt_group_id => @pt_group.id)
    end
    it "generates excel for salary sheet for employee whose date of leaving is not present" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee)
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :salary_sheet, :month_year => "Feb/2011", :format => "xls"
      response.should render_template('salaries/salary_sheet')
    end

    it "generates excel for salary sheet for employee whose date of leaving is present" do
      attendance_configuration = FactoryGirl.create(:attendance_configuration)
      financial_institution = FactoryGirl.create(:financial_institution)
      employee = FactoryGirl.create(:employee,:date_of_leaving => "2011-02-15",:leaving_reason => 'Without Reason')
      employee_detail = FactoryGirl.create(:employee_detail,:attendance_configuration_id => attendance_configuration.id,:branch_id => @branch.id, :financial_institution_id => financial_institution.id)
      pt_detail = FactoryGirl.create(:pt_detail,:branch_id => @branch.id,:pt_group_id => @pt_group.id,:pt_effective_date => '2011-01-01')
      salary_head = FactoryGirl.create(:salary_head)
      salary_group_detail = FactoryGirl.create(:salary_group_detail,:salary_head_id=> salary_head.id)
      salary = FactoryGirl.create(:salary,:employee_id => employee.id, :salary_head_id => salary_head.id, :salary_group_detail_id => salary_group_detail.id)
      pf_calculated_value = FactoryGirl.create(:pf_calculated_value, :employee_id => employee.id)

      get :salary_sheet, :month_year => "Feb/2011", :format => "xls"
      response.should render_template('salaries/salary_sheet')
    end
  end
end