class VotesController < ApplicationController
    def create
      @article = Article.find_by id: params[:article_id]
      @article.liked_by current_user
      respond_to do |format|
        format.html{redirect_to @article}
        format.js{render :vote}
      end
    end
  
    def destroy
      @article = article.find_by id: params[:article_id]
      @article.disliked_by current_user
      respond_to do |format|
        format.html{redirect_to @article}
        format.js{render :vote}
      end
    end
  end