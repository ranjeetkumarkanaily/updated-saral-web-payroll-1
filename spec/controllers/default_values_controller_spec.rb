require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe DefaultValuesController do

  # This should return the minimal set of attributes required to create a valid
  # DefaultValue. As you add validations to DefaultValue, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all default_values as @default_values" do
      default_value = DefaultValue.create! valid_attributes
      get :index
      assigns(:default_values).should eq([default_value])
    end
  end

  describe "GET show" do
    it "assigns the requested default_value as @default_value" do
      default_value = DefaultValue.create! valid_attributes
      get :show, :id => default_value.id
      assigns(:default_value).should eq(default_value)
    end
  end

  describe "GET new" do
    it "assigns a new default_value as @default_value" do
      get :new
      assigns(:default_value).should be_a_new(DefaultValue)
    end
  end

  describe "GET edit" do
    it "assigns the requested default_value as @default_value" do
      default_value = DefaultValue.create! valid_attributes
      get :edit, :id => default_value.id
      assigns(:default_value).should eq(default_value)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DefaultValue" do
        expect {
          post :create, :default_value => valid_attributes
        }.to change(DefaultValue, :count).by(1)
      end

      it "assigns a newly created default_value as @default_value" do
        post :create, :default_value => valid_attributes
        assigns(:default_value).should be_a(DefaultValue)
        assigns(:default_value).should be_persisted
      end

      it "redirects to the created default_value" do
        post :create, :default_value => valid_attributes
        response.should redirect_to(DefaultValue.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved default_value as @default_value" do
        # Trigger the behavior that occurs when invalid params are submitted
        DefaultValue.any_instance.stub(:save).and_return(false)
        post :create, :default_value => {}
        assigns(:default_value).should be_a_new(DefaultValue)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DefaultValue.any_instance.stub(:save).and_return(false)
        post :create, :default_value => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested default_value" do
        default_value = DefaultValue.create! valid_attributes
        # Assuming there are no other default_values in the database, this
        # specifies that the DefaultValue created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DefaultValue.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => default_value.id, :default_value => {'these' => 'params'}
      end

      it "assigns the requested default_value as @default_value" do
        default_value = DefaultValue.create! valid_attributes
        put :update, :id => default_value.id, :default_value => valid_attributes
        assigns(:default_value).should eq(default_value)
      end

      it "redirects to the default_value" do
        default_value = DefaultValue.create! valid_attributes
        put :update, :id => default_value.id, :default_value => valid_attributes
        response.should redirect_to(default_value)
      end
    end

    describe "with invalid params" do
      it "assigns the default_value as @default_value" do
        default_value = DefaultValue.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DefaultValue.any_instance.stub(:save).and_return(false)
        put :update, :id => default_value.id, :default_value => {}
        assigns(:default_value).should eq(default_value)
      end

      it "re-renders the 'edit' template" do
        default_value = DefaultValue.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DefaultValue.any_instance.stub(:save).and_return(false)
        put :update, :id => default_value.id, :default_value => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested default_value" do
      default_value = DefaultValue.create! valid_attributes
      expect {
        delete :destroy, :id => default_value.id
      }.to change(DefaultValue, :count).by(-1)
    end

    it "redirects to the default_values list" do
      default_value = DefaultValue.create! valid_attributes
      delete :destroy, :id => default_value.id
      response.should redirect_to(default_values_url)
    end
  end

end
