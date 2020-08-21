class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page]).per Settings.category.per_page

    respond_to do |format|
      format.html{render :index}
      format.js
    end
  end
end
