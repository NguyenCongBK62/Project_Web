class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @article = current_user.articles.build
      @feed_items = current_user.articles.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
  def contact
  end
end
