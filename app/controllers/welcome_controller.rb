class WelcomeController < ApplicationController
  before_action :redirect
  def index
  	if user_signed_in?
	  	if current_user.is_admin?
	  		if params[:start_date].present? && params[:end_date].present?
	  			if (DateTime.parse(params[:end_date]) - DateTime.parse(params[:start_date])).to_i > 800
	  				@data = set_sell_for_segment(Contact.ventas_aprobadas.where("date_close >= ? and date_close <= ?", params[:start_date], params[:end_date]).group_by { |m| m.date_close.strftime('%y') })
	  			elsif (DateTime.parse(params[:end_date]) - DateTime.parse(params[:start_date])).to_i > 30
	  				@data = set_sell_for_segment(Contact.ventas_aprobadas.where("date_close >= ? and date_close <= ?", params[:start_date], params[:end_date]).group_by { |m| m.date_close.strftime('%m-%y') })
	  			else
	  				@data = set_sell_for_segment(Contact.ventas_aprobadas.where("date_close >= ? and date_close <= ?", params[:start_date], params[:end_date]).group_by { |m| m.date_close })
	  			end
	  		else
	  			@data = set_sell_for_segment(Contact.ventas_aprobadas.ultimos_30_dias.group_by { |m| m.date_close })
	  		end
	  		@user_sell = get_list_sells_user(get_data_liners).sort_by {|x| x[1]}.reverse!
	  	elsif current_user.is_recepcion?
	  		@contacts = get_clients_in_process(current_user)
	  	elsif current_user.is_vendor?
	  		@user_sell = get_sells_for_user(current_user)
      else
        @company = Company.all
	  	end
    else
      @company = Company.all
	  end
  end

  private
  	def get_clients_in_process(user)
  		array_users = Array.new
  		user.companys.each do |compania|
  			compania.campaign.each do |campaign|
  				campaign.contacts.ventas_faltantes.each do |contact|
  					array_users.push(contact)
  				end
  			end
  		end
  		return array_users
  	end
  	def get_data_liners
  		return User.liners.active
  	end
  	def get_list_sells_user(users)
  		data_users = Array.new
  		users.each do |user|
  			data_users.push get_sells_for_user(user)
  		end
  		return data_users
  	end
  	def get_sells_for_user(user)
      @total_user = 0
      commission = 0
  		user.contacts.ventas_aprobadas.ultimo_mes.each do |ventas|
        subtotal = 0
  			if ventas.contract.sell_price
    				subtotal = ventas.contract.sell_price
    		else
    				subtotal = ventas.contract.price_rent
    		end
        @total_user = @total_user + subtotal
        if ventas.contract.commission.present?
          commission = commission + ((subtotal * ventas.contract.commission)/100)
        end
		  end
		  return [user,@total_user,commission]
  	end
  	def set_sell_for_segment(segment)
  		data = Array.new
  		segment.each do |sub_array|
  			total = 0
  			sub_array[1].each do |x|
  				if x.contract.sell_price
  					total = total + x.contract.sell_price
  				else
  					total = total + x.contract.price_rent
  				end
  				
			end
			data.push [sub_array[0], total]
		end
		return data
  	end
  	
end
