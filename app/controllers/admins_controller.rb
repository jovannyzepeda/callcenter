class AdminsController < ApplicationController
  before_action :set_user
  before_action :autenticacion_root
  before_action :first_user


  # # GET /admins
  # GET /admins.json
  def index
    @users = User.active
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @user = User.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @pass = "system123456"
    @user = User.new(user_parames)
    if User.last
      @user.number = User.last_active.number
    else
      @user.number = 0
    end
    @user.status = 1
    @user.password = "system123456"
    @user.password_confirmation = "system123456"
    unless @first_user.present?
      @user.privilegio = 7
    end
    if @user.save
      Notificacion.bienvenida(@user,@pass).deliver
      flash[:notice] = "User created correctly." 
      redirect_to admins_path
    else
      flash[:notice] = "Wrong data or less password to 8 characters."
      render :action => 'new'
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
      if @user.privilegio == 7
        if @user.update(user_parames)
          flash[:notice] = "User updated successfully." 
            redirect_to admins_path
        else
          flash[:notice] = "Wrong data or less password to 8 characters."
          render :action => 'edit'
        end
      else
        if @user.update(user_params)
          flash[:notice] = "User updated successfully." 
            redirect_to admins_path
        else
          flash[:notice] = "Wrong data or less password to 8 characters."
          render :action => 'edit'
        end
      end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    user = User.find_by(id: params[:id])
    if user.privilegio != 7
      user.email = user.email + user.id.to_s
      user.encrypted_password = '$2a$10$BttO0P5nE9k9n5lsIwZoc.G5x5hg8vIOkm3iM9GJyoFwq9uN51mKC'
      user.eliminado = true
      user.status = 0
      if user.save
        respond_to do |format|
          format.html { redirect_to admins_url, notice: 'User successfully destroyed' }
          format.json { head :no_content }
        end
      else
        flash[:notice] = "An error has occurred."
        redirect_to admins_path
      end
    else
      respond_to do |format|
          format.html { redirect_to admins_url, notice: "Can't delete this user" }
          format.json { head :no_content }
        end
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def first_user
      @first_user = User.first
    end 
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_parames
      params.require(:user).permit(:email, :privilegio, :nombre, :meta)
    end
    def user_params
      params.require(:user).permit(:email, :nombre, :meta)
    end
end