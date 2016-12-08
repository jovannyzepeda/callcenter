class UsergroupsController < ApplicationController
	before_action :set_group, only: [:create]

	def create
		@usergroup = @group.usergroup.new(usergroup_params)
	    respond_to do |format|
	      if @usergroup.save
	        format.html { redirect_to :back, notice: 'User was successfully added.' }
	      else
	        format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
	      end
	    end
	end
	def destroy
		@usergroup = Usergroup.where(group_id: params[:group_id], user_id: params[:id]).first
		if @usergroup.destroy
		    respond_to do |format|
		      format.html { redirect_to :back, notice: 'Group was destroyed sucessfully.' }
		    end
		else
			respond_to do |format|
		      format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
		    end
		end	
		
	end
	def set_group
      @group = Group.find(params[:group_id])
    end
	def usergroup_params
      params.require(:usergroup).permit(:user_id)
    end
end