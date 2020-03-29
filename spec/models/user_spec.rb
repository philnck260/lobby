require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do 
    @user = User.create(first_name: "John" || " ", last_name: "Doe" || " ", username: "johndoe")
  end

  context "validation" do

      subject { User.new(username: "my_username") }    
      it { should validate_uniqueness_of(:username).with_message(": Ce nom d'utilisateur existe déjà") }

      it "should validate first name length" do
        expect validate_length_of(:first_name).is_at_least(1).is_at_most(20)   
      end

      it "should validate last name length" do
      expect validate_length_of(:last_name).is_at_least(1).is_at_most(50)
    end


  end

  context "associations" do

    describe "user" do

      it { expect(@user).to have_many(:posts) }
      it { expect(@user).to have_many(:replies) }
      it { expect(@user).to have_many(:user_commitments) }
      it { expect(@user).to have_many(:commitments) }
      it { expect(@user).to have_many(:user_themes) }
      it { expect(@user).to have_many(:themes) }
    end
  end
end