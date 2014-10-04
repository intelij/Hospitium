require 'spec_helper'

describe AnimalColor do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:animals)}
  end

  describe "validations" do
    it{should validate_presence_of(:color)}
    it{should validate_presence_of(:organization_id)}
  end

  
end