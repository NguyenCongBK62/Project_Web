class ArticlesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    def create
        @article = current_user.articles.build(article_params)
        byebug
        @article.image.attach(params[:article][:image])
        if @article.save
            flash[:success] = "article created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @article.destroy
        flash[:success] = "article deleted"
        redirect_to request.referrer || root_url
    end
    private
    def article_params
        params.require(:article).permit(:content, :image)
    end
    def correct_user
        @article = current_user.articles.find_by(id: params[:id])
        redirect_to root_url if @article.nil?
    end
    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end
end
