require 'spec_helper'

describe OptionSettingsController do

  before :each do
    controller.stub(:logged_in?).and_return(true)
  end

  def valid_attributes
    {
        :country_id => 1,
        :time_zone => "(GMT+05:30) Kolkata",
        :currency => "rupee"
    }
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OptionSettingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all option_settings as @option_settings" do
      option_setting = OptionSetting.create! valid_attributes
      get :index, {}, valid_session
      assigns(:option_setting).should eq(option_setting)
    end
  end

  describe "GET edit" do
    it "assigns the requested option_setting as @option_setting" do
      option_setting = OptionSetting.create! valid_attributes
      get :edit, {:id => option_setting.to_param}, valid_session
      assigns(:option_setting).should eq(option_setting)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested option_setting" do
        option_setting = OptionSetting.create! valid_attributes
        # Assuming there are no other option_settings in the database, this
        # specifies that the OptionSetting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        OptionSetting.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => option_setting.to_param, :option_setting => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested option_setting as @option_setting" do
        option_setting = OptionSetting.create! valid_attributes
        put :update, {:id => option_setting.to_param, :option_setting => valid_attributes}, valid_session
        assigns(:option_setting).should eq(option_setting)
      end

      it "redirects to the option_setting" do
        option_setting = OptionSetting.create! valid_attributes
        put :update, {:id => option_setting.to_param, :option_setting => valid_attributes}, valid_session
        response.should redirect_to(edit_option_setting_path(option_setting))
      end
    end

    describe "with invalid params" do
      it "assigns the option_setting as @option_setting" do
        option_setting = OptionSetting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OptionSetting.any_instance.stub(:save).and_return(false)
        put :update, {:id => option_setting.to_param, :option_setting => {}}, valid_session
        assigns(:option_setting).should eq(option_setting)
      end

      it "re-renders the 'edit' template" do
        option_setting = OptionSetting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OptionSetting.any_instance.stub(:save).and_return(false)
        put :update, {:id => option_setting.to_param, :option_setting => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

end
