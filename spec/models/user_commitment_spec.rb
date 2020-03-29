require 'rails_helper'

RSpec.describe UserCommitment, type: :model do

    before(:each) do 
        @user = User.create(first_name: "John" || " ", last_name: "Doe" || " ", username: "johndoe")
      end

    before(:each) do 
        @commitment = Commitment.create(title: "A nice title", description: "A pretty description")   
    end  

    context "associations" do

        describe "user_commitment" do

            it { should belong_to(:user) }
            it { should belong_to(:commitment) }
        end      
    end    

    context "validation" do

        it { expect validate_uniqueness_of(:commitment).scoped_to(:user).with_message("Vous avez déjà rejoint ce Mouvement.") }
    end

end
