require 'rails_helper'

RSpec.describe Theme, type: :model do


    context "validation" do

        it { should validate_presence_of(:title) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:sources) }
        
        it { should accept_nested_attributes_for(:sources) }
    end

    context "associations" do

        describe "theme" do
  
        it { should have_many(:user_themes).dependent(:destroy) }
        it { should have_many(:users).through(:user_themes) } 
        it { should have_many(:commitment_themes).dependent(:destroy) }
        it { should have_many(:commitments).through(:commitment_themes) }
        it { should have_many(:sources).dependent(:destroy) }

        it { should accept_nested_attributes_for(:sources).allow_destroy(true) }

        end
    end
end
