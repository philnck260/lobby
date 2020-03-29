require 'rails_helper'

RSpec.describe Source, type: :model do


  context "validation" do

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:media) }
  end

    context "association" do

        describe "source" do

            it { should belong_to(:sourceable) }
        end
    end            
end
