class DownloadController < ApplicationController
  before_action :set_file, only: [:download]
  protect_from_forgery except: :download

  def download
    if session[:user_id] || session[:admin_id]
        redirect_to('/404') && return if @file.nil?
        file_path = "#{Rails.root}/public#{@file.file.url}"
        file_name = params[:filename]; file_name += ".#{params[:format]}" if params[:format]
        send_file(file_path, filename: file_name)
    else
        redirect_to login_path
    end
  end

  private

  def set_file
    @file = Manage::Fileworker.find(params[:id])
  end
end
