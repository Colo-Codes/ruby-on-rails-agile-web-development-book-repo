class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart

#   def index
#     @products = Product.order(:title)
#     @date_and_time = Time.now
    
#     # Logger
#     config.logger = Logger.new(STDOUT)
#     logger.debug "Session id: #{session[:session_id]}"
#     logger.debug Cart.find(session[:cart_id]).line_items.count
#     logger.debug @cart.line_items.count
    
#     # Session counter
#     if session[:counter].nil?
#       session[:counter] = 0
#     end
#     session[:counter] += 1
#   end
# end

def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end