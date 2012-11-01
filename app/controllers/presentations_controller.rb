class PresentationsController < ApplicationController
	
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

	def show
		@presentation = Presentation.find_by_name(params[:id])
	end

end
