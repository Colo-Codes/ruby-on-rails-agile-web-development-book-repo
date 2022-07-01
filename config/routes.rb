#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  # All default routes for Products
  resources :products
  # Routes for Store
  root 'store#index', as: 'store_index'
  resources :products do
    get :who_bought, on: :member
  end
end
