class CategoriesController < ApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url, notice: exception.message
  end

  load_and_authorize_resource
  before_filter :require_login

  def index
    @Categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Successfully saved"
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "Successfully edited"
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "Successfully deleted"
  end

  def show
    @category = Category.find(params[:id])
  end

  def get_subcategories
    categories = Category.where(parent_category_id: params[:category_id])
    #render plain: categories.map{|r| [r.name,r.id]}
    render json: categories.collect { |r| {id: r.id, text: r.name} }
  end

  private
  def category_params
    params.require(:category).permit(:name, :parent_category_id)
  end
end
