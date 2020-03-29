require 'rails_helper'

RSpec.describe CommitmentTheme, type: :model do

  context "associations" do

    describe "commitment_theme" do

        it { should belong_to(:commitment) }
        it { should belong_to(:theme) }
    end   
  end            
end
