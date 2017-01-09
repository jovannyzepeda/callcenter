class UsercompaniesController < ApplicationController
	before_action :set_company, only: [:create]
	before_action :autenticacion_companygroup
	def create
		@usercompany = @company.usercompany.new(usercompany_params)

	    respond_to do |format|
	      if @usercompany.save
	        format.html { redirect_to :back, notice: 'Group was successfully created.' }
	      else
	        format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
	      end
	    end
	end
	def destroy
		@usercompany = Usercompany.where(user_id: params[:id], company_id: params[:company_id]).first
		if @usercompany.destroy
		    respond_to do |format|
		      format.html { redirect_to :back, notice: 'Administator was removed sucessfully.' }
		    end
		else
			respond_to do |format|
		      format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
		    end
		end	
		
	end
	def set_company
      @company = Company.find(params[:company_id])
    end
	def usercompany_params
      params.require(:usercompany).permit(:user_id)
    end
end