class HistorycontactsController < ApplicationController
  before_action :set_contact

  # POST /companies
  # POST /companies.json
  def create
    @historycontact = @contact.historycontacts.new(historycontact_params)
    @historycontact.user_id = current_user.id
    respond_to do |format|
      if @historycontact.save && @contact.update(status: "Process")
        format.html { redirect_to :back, notice: 'Action was successfully created.' }
      else
        format.html { redirect_to :back, notice: 'An error has occurred.' }
      end
    end
  end

  def download
    @file = Historycontact.find(params[:id])
    send_file @file.attachment.path
  end

  private
    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historycontact_params
      params.require(:historycontact).permit(:title, :attachment, :content, :email)
    end
end
