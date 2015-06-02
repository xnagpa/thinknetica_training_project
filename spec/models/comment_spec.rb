require 'rails_helper'


RSpec.describe Question, type: :model do

describe "Comment" do
  
  before(:each) do
   @comment =Question.new	
  end
	
   it "should have parent" do
      @comment.parent_question_id = nil
      @comment.should_not be_valid
    end

end

end
