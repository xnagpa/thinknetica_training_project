class SubscriptionsController < ApplicationController
  respond_to :js

    before_action :find_subscription, only: [:destroy]
    before_action :find_subscrivable, only: [:create]


    authorize_resource #except: :create

    def create
      
      @subscription= @question.subscriptions.new
      @subscription.user = current_user
      @subscription.save
    end

    def destroy

      @question = @subscription.subscrivable
      respond_with(@subscription.destroy)
    end

    private

    def find_subscription
      @subscription = Subscription.find(params[:id])
    end

    def find_subscrivable
      @question = Question.find(params[:question_id])
    end


  end
