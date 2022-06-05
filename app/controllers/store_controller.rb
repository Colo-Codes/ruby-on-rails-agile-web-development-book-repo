class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @date_and_time = Time.now
  end
end
