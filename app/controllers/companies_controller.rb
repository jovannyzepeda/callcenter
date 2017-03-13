class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :autenticacion_companygroup
  before_action :set_representante, only: [:edit, :new]
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.activos
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @usercompany = Usercompany.new
    @usersadministrator = User.where("privilegio > 1 and id not in(select user_id from usercompanies where(company_id = #{@company.id}))").activos.map{ |c| [c.nombre, c.id] }
    @users = User.all.activos.map{ |c| [c.nombre, c.id] }
    @signempresa = Signempresa.new
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.password = Company.codificar(@company.password)
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        @company.update(password:Company.codificar(@company.password))
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    respond_to do |format|
      if @company.update(eliminado: true)
        format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      else 
        format.html { redirect_to companies_url, notice: 'Error.' }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end
    def set_representante
      @legals = User.where("privilegio = 4").activos.map{|c| [c.nombre, c.id]}
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:nombre, :logo, :address, :username, :password, :port, :security, :user_id)
    end
end
