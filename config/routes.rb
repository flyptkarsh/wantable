Rails.application.routes.draw do
  root 'admin#index'
  resources :orders, only: %i[index show], param: :number
  resources :reports, only: :index
  get 'reports/coupon_users', to: 'reports#coupon_users'
  get 'reports/sales_by_product', to: 'reports#sales_by_product'
end
