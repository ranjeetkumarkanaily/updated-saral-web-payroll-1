require 'spec_helper'

describe "pf_groups/new" do
  before(:each) do
    assign(:pf_group, stub_model(PfGroup,
      :pf_group => "MyString",
      :pf_number => "MyString",
      :db_file_code => "MyString",
      :extension => 1,
      :address => "MyString"
    ).as_new_record)
  end

  it "renders new pf_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pf_groups_path, :method => "post" do
      assert_select "input#pf_group_pf_group", :name => "pf_group[pf_group]"
      assert_select "input#pf_group_pf_number", :name => "pf_group[pf_number]"
      assert_select "input#pf_group_db_file_code", :name => "pf_group[db_file_code]"
      assert_select "input#pf_group_extension", :name => "pf_group[extension]"
      assert_select "input#pf_group_address", :name => "pf_group[address]"
    end
  end
end
