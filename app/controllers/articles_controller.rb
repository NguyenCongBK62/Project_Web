class ArticlesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    def create
        @article = current_user.articles.build(article_params)
        # @article.image.attach(params[:article][:image])
        if @article.save
            flash[:success] = "article created!"
            @feed_items = current_user.feed.paginate(page: params[:page])
            redirect_to root_url
        else
            flash[:success] = "article created fails!"
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        if  @article.destroy
            flash[:success] = "article deleted"
            redirect_to request.referrer || root_url
        else 
            flash[:danger] = "delete fails"
            render 'static_pages/home'
        end
    end
    private
    def article_params
        params.require(:article).permit(:content, :image)
    end
    def correct_user
        @article = current_user.articles.find_by(id: params[:id])
        redirect_to root_url if @article.nil?
    end
end
