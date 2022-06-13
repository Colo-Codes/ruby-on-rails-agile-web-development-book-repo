class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @date_and_time = Time.now
    
    # Logger
    config.logger = Logger.new(STDOUT)
    logger.debug "Session id: #{session[:session_id]}"
    logger.debug Cart.find(session[:cart_id]).line_items.count
    logger.debug @cart.line_items.count
    
    # Session counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
end
