class GuessesController < ApplicationController
  def create
     respond_to do |f|
      f.html do
        redirect_to played_game_path(@played_game)
      end
      f.js do
        separated_coords = Location.separate_lat_lon(params[:location])
        @location = Location.create(latitude: separated_coords[0], longitude: separated_coords[1])
        @guess = Guess.create(:played_game_id => params[:played_game_id], :user_id => current_user.id, :location_id => @location.id )
        @played_game = Played_game.find(params[:played_game_id])
        @guesses = []
        @played_game.guesses.each do |g|
          @guesses << g.location
        end
       end

     end
  end
end
