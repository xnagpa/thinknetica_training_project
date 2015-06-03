require 'rails_helper'

RSpec.describe QuestionController, type: :controller do
	
	describe 'GET #index' do
		before{ get :index}
		
		it { should respond_with(200)}
		it { should render_template('index')}
		it { should render_template(partial:'questions')}
		
	end

	describe 'Routing' do 
		it { should route (:get,'/questions').to(action: :index)}
		it { should route (:get)}
	end

end
