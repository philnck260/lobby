require 'rails_helper'

RSpec.describe UserTheme, type: :model do

    context "associations" do

        describe "user_theme" do

             it { should belong_to(:user) }
             it { should belong_to(:theme) }
        end
    end            

    context "validation" do

        it { expect validate_uniqueness_of(:theme).scoped_to(:user).with_message("Vous suivez déjà ce Thème.") }
    end

end
