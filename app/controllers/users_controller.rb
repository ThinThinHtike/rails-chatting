class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @room = Room.new
    @rooms = Room.public_room
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)
    #puts @single_room
    @message = Message.new
    #@messages = @single_room.messages.order(created_at: :asc)
    pagy_messages = @single_room.messages.order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 5)
    @messages = messages.reverse

    render 'rooms/index'
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end
  
end
