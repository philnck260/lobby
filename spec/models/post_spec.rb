require 'rails_helper'

RSpec.describe Post, type: :model do

    before(:each) do 
        @post = Post.create(title: "Hello world", content: "contain some good content")

    end
      

    context "validation" do
        
        describe Post do
            it { expect validate_presence_of(:title) }
        end

        describe Post do
            
            it do
                expect validate_length_of(:title).
                    is_at_least(5).is_at_most(50).
                    with_message("Un titre de post est requis")
            end
        end

        describe Post do
            it { expect validate_presence_of(:content) }
        end

        describe Post do
            it do
                expect validate_length_of(:content).
                    is_at_least(5).is_at_most(500).
                    with_message("Un contenu de post est requis")
            end
        end
    end

    context "associations" do

        describe "reply" do

            it { should belong_to(:user) }
            it { should belong_to(:forum) }
            it { expect(@post).to have_many(:replies) }
        end
    end            
end