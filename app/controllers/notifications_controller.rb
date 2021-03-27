class NotificationsController < ApplicationController

  before_action :authenticate_user!

  def index
    notifications = Notification.where(visited_id: current_user.id)
    notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = notifications.page(params[:page]).per(5)
  end

  def destroy
    #通知を削除
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to notifications_path
  end
end