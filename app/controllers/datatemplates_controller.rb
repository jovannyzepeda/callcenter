class DatatemplatesController < ApplicationController
  before_action :set_datatemplate, only: [:show, :edit, :update, :destroy]
  before_action :set_data
  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    @datatemplate = Datatemplate.new
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @datatemplate = @template.datatemplates.new(datatemplate_params)
    respond_to do |format|
      if @template.save
        format.html { redirect_to :back, notice: 'Data template was successfully added.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @datatemplate.update(datatemplate_params)
        format.html { redirect_to [@company,@template], notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @datatemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @datatemplate.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Data templatesemplate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datatemplate
      @datatemplate = Datatemplate.find(params[:id])
    end
    def set_data
      @company = Company.find(params[:company_id])
      @template = Template.find(params[:template_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datatemplate_params
      params.require(:datatemplate).permit( :content,:width,:height,:fontsize, :left_width, :color)
    end
end
