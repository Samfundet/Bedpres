# encoding: UTF-8

class ParticipationsController < ApplicationController
  filter_access_to :all

  def destroy
    @participation = Participation.where(:presentation_id => params[:presentation_id],
                                         :participle_id => @current_user.id,
                                         :participle_type => @current_user.class.name).first

    if @participation.destroy
      flash[:success] = "Du er nå avmeldt presentasjonen."
    else
      flash[:error] = @participation.errors.full_messages.first
    end

    redirect_to @participation.presentation
  end

  def create
    @participation = Participation.new(
      :participle => @current_user,
      :presentation_id => params[:presentation_id]
    )

    if @participation.save
      flash[:success] = "Du er nå påmeldt presentasjonen."
    else
      flash[:error] = @participation.errors.full_messages.first
    end

    redirect_to presentation_path(params[:presentation_id])
  end
end
