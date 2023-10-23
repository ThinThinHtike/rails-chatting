class RoomsController < ApplicationController
  before_action :authenticate_user!
  after_action :set_status
  def index
    @room = Room.new
    @rooms = Room.public_room

    @users = User.all_except(current_user)

    render 'index'
  end

  def show
    @room = Room.new
    @rooms = Room.public_room

    @single_room = Room.find(params[:id])

    @message = Message.new
    #@messages = @single_room.messages.order(created_at: :asc)
    pagy_messages = @single_room.messages.order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 5)
    @messages = messages.reverse

    @users = User.all_except(current_user)

    render 'index'
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end

  private

  def set_status
    current_user.update!(status: User.statuses[:online]) if current_user
  end
end
