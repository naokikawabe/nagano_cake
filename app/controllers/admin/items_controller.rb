class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
     @item = Item.new(item_params)
     if @item.save
      redirect_to admin_item_path(@item.id)
     end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genre = Genre.all
  end

  def update
    @item = Item.find(params[:id])
   if @item.update(item_params)
    redirect_to admin_item_path(@item.id)
   end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
  end

end