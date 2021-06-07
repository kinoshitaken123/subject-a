class ChatsController < ApplicationController
    def 
         # どのユーザーとチャットするかを取得。
        @user = User.find(params[:id])
        # カレントユーザーのuser_roomにあるroom_idの値の配列をroomsに代入。
        rooms = current_user.user_rooms.pluck(:room_id)
        # user_roomモデルから
        # user_idがチャット相手のidが一致するものと、
        # room_idが上記roomsのどれかに一致するレコードを
        # user_roomsに代入。
        user_rooms UseRoom.find_by(user_id: @user.id, room_id: rooms)
        # もしuser_roomが空でないなら
       unless user_rooms.nill?
         # @roomに上記user_roomのroomを代入
         @room = user_rooms.room
       else
         # それ以外は新しくroomを作り、
         @room = Room.new
         @room.save
        # user_roomをカレントユーザー分とチャット相手分を作る
         UserRoom.create(user_id: current_user.id, room_id: @room_id)
         UserRoom.create(user_id: @user.id, room_id: @room.id)
       end
        @chats = @room.chats
        @chat = Chat.new(room_id: @room.id)
    end

end
