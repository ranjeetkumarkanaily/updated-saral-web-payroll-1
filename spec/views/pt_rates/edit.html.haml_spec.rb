require 'spec_helper'

describe "pt_rates/edit" do
  before(:each) do
    @pt_group = FactoryGirl.create(:pt_group)
    @paymonth = FactoryGirl.create(:paymonth)
    @pt_rate = assign(:pt_rate, stub_model(PtRate,
      :pt_group => @pt_group,
      :paymonth => @paymonth,
      :min_sal_range => "9.99",
      :max_sal_range => "9.99",
      :pt => "9.99"
    ))
  end

  it "renders the edit pt_rate form" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pt_rates_path(@pt_rate), :method => "post" do
      #assert_select "select#pt_rate_pt_group_id", :name => "pt_rate[pt_group_id]"
      #assert_select "select#pt_rate_paymonth_id", :name => "pt_rate[paymonth_id]"
      assert_select "input#pt_rate_min_sal_range", :name => "pt_rate[min_sal_range]"
      assert_select "input#pt_rate_pt", :name => "pt_rate[pt]"
    end
  end
end
