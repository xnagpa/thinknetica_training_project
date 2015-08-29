class SearchesController < ApplicationController
  respond_to :html

  skip_authorization_check

  def show
    # search_params[:search_field]  looks weird
    search_type = params[:search_type]

    if search_type == 'All'

      @result = ThinkingSphinx.search search_params[:search_field], page: search_params[:page], per_page: 5
    else

      @result = search_type.singularize.classify.constantize.search search_params[:search_field], page: search_params[:page], per_page: 5
    end
  end

  def search_params
    params.permit(:search_field, :page, :commit)
  end
end
