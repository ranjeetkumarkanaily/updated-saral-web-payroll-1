require 'spec_helper'

describe "salary_group_details/edit" do

  it "renders the edit salary_group_detail form" do
    salary_group = FactoryGirl.create(:salary_group)
    assign(:param_sal_grp_id, salary_group.id)
    @salary_group_detail = assign(:salary_group_detail, stub_model(SalaryGroupDetail,
       :calc_type => "MyString",
       :calculation => "MyString",
       :based_on => "MyString",
       :salary_group => nil,
       :salary_head => nil,
       :print_order => 1
    ))
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => salary_group_details_path(@salary_group_detail), :method => "post" do
      assert_select "select#salary_group_detail_calc_type", :name => "salary_group_detail[calc_type]"
      assert_select "textarea#salary_group_detail_calculation", :name => "salary_group_detail[calculation]"
      assert_select "select#salary_group_detail_based_on", :name => "salary_group_detail[based_on]"
      assert_select "select#salary_group_detail_salary_head_id", :name => "salary_group_detail[salary_head]"
      assert_select "input#salary_group_detail_print_order", :name => "salary_group_detail[print_order]"
    end
  end
end
