# encoding: UTF-8

class ParticipationsController < ApplicationController
  filter_access_to :all

  def destroy
    @participation = Participation.where(:presentation_id => params[:presentation_id],
                                         :participle_id => @current_user.id,
                                         :participle_type => @current_user.class.name).first

    if Time.now >= @participation.presentation.presentation_date
      flash[:error] = "Du kan ikke melde deg av etter at presentasjonen er over."
    else
      @participation.destroy
      flash[:success] = "Du er nå avmeldt presentasjonen."
    end

    redirect_to @participation.presentation
  end

  def create
    @presentation = Presentation.find(params[:presentation_id])

    if @presentation.canceled
      flash[:error] = "Denne presentasjonen er desverre avlyst."
      redirect_to @presentation
    elsif Time.now >= @presentation.presentation_date
      flash[:error] = "Påmelding for denne presentasjonen er dessverre avsluttet."
      redirect_to @presentation
    elsif @presentation.participations.size >= @presentation.guest_limit
      flash[:error] = "Denne presentasjonen er desverre full."
      redirect_to @presentation
    else
      if @presentation.users.include? @current_user
        flash[:error] = "Du er allerede påmeldt denne presentasjonen."
        redirect_to @presentation
      else
        @participation = Participation.new(
          :participle => @current_user,
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
