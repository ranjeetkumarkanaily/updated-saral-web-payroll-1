require 'spec_helper'

describe CompaniesController do
  before :each do
    controller.stub(:logged_in?).and_return(true)
  end

  def valid_attributes
    {:companyname => "Its My company Ltd.",
    :responsible_person => "Myself",
    :address => "My company address",
    :website => "www.mycompany.com",
    :dateofestablishment => "2010-10-30",
    :pf => true,
    :esi => true,
    :phonenumber1 => "080201256",
    :phonenumber2 => "080201256" ,
    :address2 => "My company address 2",
    :address3 => "My company address 3",
    :email => "mycomap@comp.com"}
  end

    describe "GET index" do
      it "assigns the first company as @company" do
        company = Company.create! valid_attributes
        get :index
        assigns(:company).should eq(company)
      end
    end

    describe "GET new" do
      it "assigns a new company as @company" do
        get :new
        assigns(:company).should be_a_new(Company)
      end
    end

    describe "GET edit" do
      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        get :edit, :id => company.id
        assigns(:company).should eq(company)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "creates a new Company" do
          expect {
            post :create, :company => valid_attributes
          }.to change(Company, :count).by(1)
        end

        it "assigns a newly created company as @company" do
          post :create, :company => valid_attributes
          assigns(:company).should be_a(Company)
          assigns(:company).should be_persisted
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved company as @company" do
          Company.any_instance.stub(:save).and_return(false)
          post :create, :company => {}
          assigns(:company).should be_a_new(Company)
        end

        it "re-renders the 'new' template" do
          Company.any_instance.stub(:save).and_return(false)
          post :create, :company => {}
          response.should render_template("new")
        end
      end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the Company" do
          company = Company.create! valid_attributes
          Company.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => company.id, :company => {'these' => 'params'}
        end

        it "assigns the requested company as @company" do
          company = Company.create! valid_attributes
          put :update, :id => company.id, :companyname => valid_attributes
          assigns(:company).should eq(company)
        end
      end
    end


    describe "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        Company.any_instance.stub(:save).and_return(false)
        put :update, :id => company.id, :company => {}
        assigns(:company).should eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        Company.any_instance.stub(:save).and_return(false)
        put :update, :id => company.id, :company => {}
        response.should render_template("edit")
      end
    end
  end

end

