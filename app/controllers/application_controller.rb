class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  def cache_key
   "#{params[:controller]}/#{params[:action]}}"
  end
end
