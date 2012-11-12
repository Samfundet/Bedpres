# encoding: UTF-8

class ParticipationsController < ApplicationController
  filter_access_to :all

  def destroy
    @participation = Participation.where(:presentation_id => params[:presentation_id], :user_id => @current_user).first

    @participation.destroy
    flash[:success] = "Du er nå avmeldt presentasjonen."
    redirect_to @participation.presentation
  end

  def create
    @presentation = Presentation.find(params[:presentation_id])

    if @presentation.canceled
      flash[:error] = "Denne presentasjonen er desverre avlyst."
      redirect_to @presentation
    elsif Time.now >= @presentation.presentation_date
      flash[:error] = "Denne presentasjonen er desverre begynt."
      redirect_to @presentation
    elsif @presentation.users.size >= @presentation.guest_limit
      flash[:error] = "Denne presentasjonen er desverre full."
      redirect_to @presentation
    else
      if @presentation.users.include? @current_user
        flash[:error] = "Du er allerede påmeldt denne presentasjonen."
        redirect_to @presentation
      else
        @participation = Participation.new(
          :user => @current_user, 
          :presentation => @presentation
        )
        if @participation.save!
          flash[:success] = "Du er nå påmeldt presentasjonen."
          redirect_to @presentation
        else
          flash[:error] = "Noe gikk galt."
          redirect_to @presentation
        end
      end
    end
  end
end
