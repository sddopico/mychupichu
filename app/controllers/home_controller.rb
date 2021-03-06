class HomeController < ApplicationController
  def index
  	if params[:search].present?
  		@chus = Chu.search(params[:search]).order("created_at DESC")
		@user = current_user
  	else
  		@posts = Chu.uniq.pluck("base")
	end
  end

  def show
		@chu = Chu.find(params[:id])
		@user = current_user
		@hash = Gmaps4rails.build_markers(@chu) do |chu, marker|
		  marker.lat chu.latitude
		  marker.lng chu.longitude
		end
		@comment = Comment.new
		@c = Comment.pluck("id")
		@comments = @chu.comments
  end
	
end


