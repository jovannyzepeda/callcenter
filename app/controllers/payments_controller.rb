class PaymentsController < ApplicationController
  before_action :set_data


  def update
    if current_user.is_recepcion?
      respond_to do |format|
        if @contract.payments.count == 1 || @contract.payments.last == @payment
          if @payment.status == true
            estado = false
          else
            estado = true
          end
          if params[:payment].present?
            @payment.update(set_params)
          end
          if @payment.update(status: estado)
            format.html {redirect_to :back, notice: "Successfully updated payment"}
          else
            format.html {redirect_to :back, notice: "An error occurred, please try again."}
          end
        else
          format.html {redirect_to :back, notice: "You can not edit a past item"}
        end 
      end
    else
      respond_to do |format|
        format.html {redirect_to :back, notice: "You can not edit this item"} 
      end
    end
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data
      @contract = Contract.find(params[:contract_id])
      @payment = Payment.find(params[:id])
    end
    def set_params
      params.require(:payment).permit(:fecha_cierre)
    end
end
