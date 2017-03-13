class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  protected
  		
		def first_user
			@first_user = User.first
		end	
		def redirect
			if first_user.blank?
				redirect_to admins_path
			end
		end
		def autenticacion_root
			redirect_to root_path unless user_signed_in? && current_user.is_admin?
		end
		def autenticacion_groupadmin
			redirect_to root_path unless user_signed_in? && current_user.is_admingroup?
		end
		def autenticacion_companygroup
			redirect_to root_path unless user_signed_in? && current_user.is_adminempresa?
		end
		def authenticacion_recepcion
			redirect_to root_path unless user_signed_in? && current_user.is_recepcion?
		end
	private
	  	def auth
	  		unless user_signed_in? 
				redirect_to new_user_session_path
			end
		end
		def get_clients_in_process(user)
	  		array_users = Array.new
	  		user.companys.each do |compania|
	  			compania.campaign.each do |campaign|
	  				campaign.contacts.ventas_faltantes.activos.each do |contact|
	  					array_users.push(contact)
	  				end
	  			end
	  		end
	  		return array_users
  		end
  		def get_clients_in_process_company(user)
	  		array_users = Array.new
	  		user.company.each do |compania|
	  			compania.campaign.each do |campaign|
	  				campaign.contacts.ventas_faltantes.activos.each do |contact|
	  					array_users.push(contact)
	  				end
	  			end
	  		end
	  		return array_users
  		end
		
end
