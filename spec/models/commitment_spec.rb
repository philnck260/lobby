require 'rails_helper'

RSpec.describe Commitment, type: :model do
  
  

  describe "commitment" do
  
      it "should validate title " do
        commitment = Commitment.create(title: "azeazeazea" )
        expect(commitment.valid?).to be(false)
        commitment.validate     
      end

  

      it "should validate description" do
        commitment = Commitment.create(description: "azeazeazeaazeazeazea")
        expect(commitment.valid?).to be(false)
        commitment.validate
      end
  end  
      
      describe " Commitment " do
       
        it { should validate_presence_of(:sources) }
        it { should validate_presence_of(:commitment_themes) }
      end
        

    context "associations" do

      describe "commitment" do
  
        it { should have_many(:user_commitments).dependent(:destroy) }
        it { should have_many(:users).through(:user_commitments) } 
        it { should have_many(:commitment_themes).dependent(:destroy) }
        it { should have_many(:themes).through(:commitment_themes) }
        it { should have_one(:forum).dependent(:destroy) }
        it { should have_many(:sources).dependent(:destroy) }
        it { should accept_nested_attributes_for(:sources) }
      end
    end
end
    