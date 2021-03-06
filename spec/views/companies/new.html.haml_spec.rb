require 'spec_helper'

describe "companies/new" do
  before(:each) do
    assign(:company, stub_model(Company,
      :companyname => "My test Company",
      :reponsible_person => "My Name",
      :address => "Address",
      :website => "www.website.com" ,
      :pt => true,
      :pf => true,
      :esi => false,
      :tds => true
    ).as_new_record)
  end

  it "renders new company form" do
    render
      assert_select "form", :action => companies_path, :method => "post" do
        assert_select "input#company_companyname", :name => "company[companyname]"
        assert_select "input#company_responsible_person", :name => "company[responsible_person]"
        assert_select "input#company_photo", :name => "company[photo]"
        assert_select "input#company_pf", :name => "company[pf]"
        assert_select "input#company_pt", :name => "company[pt]"
        assert_select "input#company_esi", :name => "company[esi]"
        assert_select "input#company_tds", :name => "company[tds]"
    end
  end
end
