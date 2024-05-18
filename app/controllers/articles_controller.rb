class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create, :new]
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if can?(:create, @article) and @article.save
      redirect_to(@article)
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if can?(:update, @article) and @article.update(article_params)
      redirect_to(@article)
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if can?(:destroy, @article)
      @article.destroy
    end

    redirect_to(root_path, status: :see_other)
  end

  def increase_report_count
    @article = Article.find(params[:id])
    @article.increment!(:report_count)
    @article.save
    redirect_to(@article)
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status, :image, :user_id)
  end

end
