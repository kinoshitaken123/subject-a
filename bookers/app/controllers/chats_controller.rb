class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: room.id).present?
      current_user.chats.create(chat_params)
      @chats = room.chats
      # redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message).merge(room_id: params[:room_id])
  end
end