require 'rails_helper'

describe Ability do
	subject(:ability) { Ability.new(user) }

	describe "for guest" do 
		let(:user){nil}
		it{ expect(subject).to be_able_to :read, Question }
		it{ expect(subject).to be_able_to :read, Answer }
		it{ expect(subject).to be_able_to :read, Comment }
		it{ expect(subject).to_not be_able_to :manage, :all }
	end

	describe "for admin" do 
		let(:user){FactoryGirl.create(:user,admin:true)}		
		it{ expect(subject).to be_able_to :manage, :all }
	end

	describe "for user" do 
		let(:user){FactoryGirl.create(:user)}		
		let(:another_user){FactoryGirl.create(:another_user)}	
		let(:question){FactoryGirl.create(:question, user: user)}
		

		it{ expect(subject).to_not be_able_to :manage, :all }
		it{ expect(subject).to be_able_to :read, :all }
		it{ expect(subject).to be_able_to :create, Question }
		it{ expect(subject).to be_able_to :create, Answer }
		it{ expect(subject).to be_able_to :create, Comment }

		#it{ expect(subject).to be_able_to :create, FactoryGirl.create(:vote, votable: question, user: another_user), user: user  }
		it{ expect(subject).to_not be_able_to :create, FactoryGirl.create(:vote, votable: question, user: user), user: user  }
		

		it{ expect(subject).to be_able_to :update, FactoryGirl.create(:question, user: user), user: user }
		it{ expect(subject).to_not be_able_to :update, FactoryGirl.create(:question, user: another_user), user: user }

		it{ expect(subject).to be_able_to :update, FactoryGirl.create(:answer, user: user), user: user }
		it{ expect(subject).to_not be_able_to :update, FactoryGirl.create(:answer, user: another_user), user: user }

		it{ expect(subject).to be_able_to :update, FactoryGirl.create(:comment, user: user), user: user }
		it{ expect(subject).to_not be_able_to :update, FactoryGirl.create(:comment, user: another_user), user: user }

		it{ expect(subject).to be_able_to :update, FactoryGirl.create(:vote, user: user), user: user }




	end
end