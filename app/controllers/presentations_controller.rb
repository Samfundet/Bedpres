class PresentationsController < ApplicationController
	filter_access_to :all
	
	def index
		@presentation = Presentation.all
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
			redirect_to presentations_path
		else
			flash.now[:error] = "Presentasjonen ble ikke opprettet."
			render :new
		end
	end

	def update
		@presentation = Presentation.find params[:id]
		if @presentation.update_attributes(params[:presentation])
			flash[:success] = "Presentasjonen er oppdatert."
			redirect_to presentation_path
		else
			flash.now[:error] = "Presentasjonen ble ikke oppdatert."
			render :edit
		end
	end

	def show
		@presentation = Presentation.find(params[:id])
	end
end
