class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    if params[:user_id].to_i == current_user.id
      redirect_back(fallback_location: root_path)
    else
      @room = Room.create
      UserRoom.create(:room_id => @room.id, :user_id => current_user.id)
      UserRoom.create(:room_id => @room.id, :user_id => params[:user_id])
      redirect_to @room
    end
  end
end
