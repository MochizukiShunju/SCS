class NotificationsController < ApplicationController
  def index
    notifications = Notification.where.not(visitor_id: current_user.id)
    notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = notifications.page(params[:page]).per(20)
  end
end
