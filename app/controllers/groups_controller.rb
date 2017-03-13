class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :autenticacion_groupadmin
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.activos
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @newuser = Usergroup.new
    @members = Usergroup.all
    @users = User.where("id not in(select user_id from usergroups where(group_id = #{@group.id}))").liners.activos.map{ |c| [c.nombre, c.id] }
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  def usergroup
    if params[:user_group].present?
      @user_group = Usergroup.new(user_id: params[:user_group], group_id: params[:group])
      respond_to do |format|
        if @user_group.save
          format.html {  redirect_to :back, notice: 'Usergroup was successfully adding.' }
        else
          format.html {  redirect_to :back, notice: 'We have a error please try again.' }
        end
      end
    else
      redirect_to :back, notice: 'You need add a user.'
    end
  end

  def usergroupdelete
    @group = Usergroup.find(params[:id])
      respond_to do |format|
        if @group.destroy
          format.html {  redirect_to :back, notice: 'User was delete from this group.' }
        else
          format.html {  redirect_to :back, notice: 'We have a error please try again.' }
        end
      end
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    respond_to do |format|
      if @group.update(eliminado: true)
        format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to groups_url, notice: 'Was ocurred an error' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:nombre)
    end
end
