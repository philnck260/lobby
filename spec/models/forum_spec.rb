require 'rails_helper'

RSpec.describe Forum, type: :model do

 
  context "associations" do

    describe "forum" do

        it { should belong_to(:commitment ).optional }    
        it { should have_many(:posts) }
      end
  end
end
