class PresentationsController < ApplicationController
  filter_access_to :all
  include NotificationHelper
  
  def index
    @upcoming_presentations = Presentation.upcoming.includes(:area, :participations)
    @past_presentations = Presentation.past.includes(:area, :participations)
    @promo = @upcoming_presentations.where("canceled = ?", false).first

    # Eagerly load the relation to avoid N queries to check if the user is participating in each presentation.
    @current_user.presentations.to_a if @current_user
  end

  def new
    @presentation = Presentation.new
  end

  def edit
    @presentation = Presentation.find params[:id]
  end

  def create
    @presentation = Presentation.new params[:presentation]

    if @presentation.save
      flash[:success] = "Presentatsjonen er opprettet."
      redirect_to root_path
    else
      flash.now[:error] = "Presentasjonen ble ikke opprettet."
      render :new
    end
  end

  def update
    @presentation = Presentation.find params[:id]
    if @presentation.update_attributes(params[:presentation])
      flash[:success] = "Presentasjonen er oppdatert."
      notify(@presentation.participants, "Presentasjonen #{@presentation.name} har blitt oppdatert.", @presentation)
      redirect_to root_path
    else
      flash.now[:error] = "Presentasjonen ble ikke oppdatert."
      render :edit
    end
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def toggle_cancel
    @presentation = Presentation.find params[:id]
    @presentation.canceled = !@presentation.canceled

    if @presentation.save
      if @presentation.canceled
        flash[:success] = "Presentasjonen er markert som avlyst."
        notify(@presentation.participants, "Presentasjonen #{@presentation.name} har blitt avlyst.", @presentation)
      else
        flash[:success] = "Presentasjonen er ikke lenger markert som avlyst."
        notify(@presentation.participants, "Presentasjonen #{@presentation.name} er ikke lenger avlyst.", @presentation)
      end

      redirect_to presentation_path @presentation
    else
      flash.now[:error] = "En feil forekom. Presentasjonen er ikke endret."
      render :show
    end
  end

  def destroy
    @presentation = Presentation.find params[:id]

    if @presentation.participations.count > 0
      flash.now[:error] = "Denne presentasjonen har allerede deltagelser og kan derfor ikke slettes."
      render :show
    else
      @presentation.destroy
      flash[:success] = "Presentasjonen er slettet."
      redirect_to root_path
    end
  end
end
