class ProductsController < ApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url, notice: exception.message
  end

  load_and_authorize_resource except: :search
  # => before_filter :require_login


  def index
    @products = Product.where('quantity > ?', 0)
  end

  def new
    @product = Product.new
    3.times { @product.photos.build }
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_url, notice: "Successfully Added"
    else
      3.times { @product.photos.build }
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    3.times { @product.photos.build }
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def search
    @products = Product.where("title like ?", "%#{params[:search]}%")

    if @products.nil?
      render 'index', notice: "No result found."
    else
      render 'index'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.quantity = 0 # = 10
    @product.save
    #@product.destroy
    redirect_to root_url, notice: "Successfully deleted"
  end

  def show
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :category_id, photos_attributes: [:image])
  end
end
