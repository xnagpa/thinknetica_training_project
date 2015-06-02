require 'rails_helper'

RSpec.describe Question, type: :model do

   before(:each) do
    @question = Question.new
  end

  it "should have title" do
    @question.title = nil
    @question.should_not be_valid
  end

   it "should have content" do
    @question.content = nil
    @question.should_not be_valid
  end

end


