require 'spec_helper'

describe "Classifications" do
  describe "GET /classifications" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get classifications_path
      response.status.should be(302)
    end
  end
end
