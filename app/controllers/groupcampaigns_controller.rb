class GroupcampaignsController < ApplicationController
	before_action :set_campaing, only: [:create]

	def create
		@groupcampaign = @campaing.groupcampaign.new(groupcampaing_params)

	    respond_to do |format|
	      if @groupcampaign.save
	        format.html { redirect_to :back, notice: 'Group was successfully created.' }
	      else
	        format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
	      end
	    end
	end
	def destroy
		@groupcampaign = Groupcampaign.where(group_id: params[:id], campaign_id: params[:campaign_id]).first
		if @groupcampaign.destroy
		    respond_to do |format|
		      format.html { redirect_to :back, notice: 'Group was destroyed sucessfully.' }
		    end
		else
			respond_to do |format|
		      format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
		    end
		end	
		
	end
	def set_campaing
      @campaing = Campaign.find(params[:campaign_id])
    end
	def groupcampaing_params
      params.require(:groupcampaign).permit(:group_id)
    end
end