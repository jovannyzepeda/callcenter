class WelcomeController < ApplicationController
  before_action :redirect
  def index
  	if user_signed_in?
	  	if current_user.is_admin?
	  		if params[:start_date].present? && params[:end_date].present?
	  			if (DateTime.parse(params[:end_date]) - DateTime.parse(params[:start_date])).to_i > 800
	  				@data = get_sells_period(Payment.ventas_aprobadas.where("fecha_cierre >= ? and fecha_cierre <= ?", params[:start_date], params[:end_date]).group_by { |m| m.fecha_cierre.strftime('%y') })
	  			elsif (DateTime.parse(params[:end_date]) - DateTime.parse(params[:start_date])).to_i > 30
	  				@data = get_sells_period(Payment.ventas_aprobadas.where("fecha_cierre >= ? and fecha_cierre <= ?", params[:start_date], params[:end_date]).group_by { |m| m.fecha_cierre.strftime('%m-%y') })
	  			else
	  				@data = get_sells_period(Payment.ventas_aprobadas.where("fecha_cierre >= ? and fecha_cierre <= ?", params[:start_date], params[:end_date]).group_by { |m| m.fecha_cierre })
	  			end
	  		else
	  			@data = get_sells_period(Payment.ventas_aprobadas.ultimos_30_dias.group_by { |m| m.fecha_cierre })
	  		end
	  		@user_sell = get_list_sells_user(get_data_liners).sort_by {|x| x[1]}.reverse!
	  	elsif current_user.is_representante?
        @contacts = get_clients_in_process_company(current_user)
      elsif current_user.is_recepcion?
	  		@contacts = get_clients_in_process(current_user)
	  	elsif current_user.is_vendor?
	  		@user_sell = get_sells_for_user(current_user)
      else
        @company = Company.activos
	  	end
    else
      @company = Company.activos
	  end
  end

  private
  	#pkey
    def get_sells_period(segment)
      data = Array.new
      segment.each do |sub_array|
        total = 0
        sub_array[1].each do |x|
          total = total + x.cantidad  
        end
        data.push [sub_array[0], total]
      end
      return data
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
  		user.payments.ventas_aprobadas.ultimo_mes.each do |ventas|
        @total_user = @total_user + ventas.cantidad
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
  					total = total + x.contract.sell_price.to_i
  				else
  					total = total + x.contract.price_rent.to_i
  				end
  				
			end
			data.push [sub_array[0], total]
		end
		return data
  	end
  	
end
