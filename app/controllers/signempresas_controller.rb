class SignempresasController < ApplicationController
	before_action :set_sign, only: [:destroy]
	def create
	    @signempresa = Signempresa.new(signempresa_params)
	    @signempresa.company_id = params[:company_id]
	    respond_to do |format|
	      if @signempresa.save
	        format.html { redirect_to :back, notice: 'User created.' }
	      else
	        format.html { redirect_to :back, notice: "Error" }
	      end
	    end
	end
	def destroy
	    respond_to do |format|
	      if @sign.update(eliminado: true)
	        format.html { redirect_to :back, notice: 'Sign and user removed.' }
	      else
	        format.html { redirect_to :back, notice: 'Was ocurred an error' }
	      end
	    end
  	end
	private
		def set_sign
			@sign = Signempresa.find(params[:id])
		end
		def signempresa_params
        	params.require(:signempresa).permit(:user_id, :firma, :nombre)
    	end
end