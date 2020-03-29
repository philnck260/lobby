require 'rails_helper'

RSpec.describe Reply, type: :model do

    

    context "validation" do

        describe Reply do
            it { expect validate_presence_of(:content) }
        end
        
        it do
            expect validate_length_of(:content).
                is_at_most(500).
                with_message(": Le contenu ne doit pas dépasser 500 caractères")
            end
    end

    context "associations" do

        describe "reply" do

            it { should belong_to(:user) }
            it { should belong_to(:post) }
        end
    end    
end