class NotificationsController < ApplicationController

  filter_access_to :destroy, :attribute_check => true


  def destroy
    @notification.destroy
    redirect_to root_path
  end

end