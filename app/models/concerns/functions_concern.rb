module FunctionsConcern
	#es para agergar tiposdeusuarios yu permisos
	extend ActiveSupport::Concern
	included do
		scope :ultimos, ->{order(created_at: :desc)}
		scope :activos, -> {where(eliminado:false).ultimos}
		scope :ventas_aprobadas, -> {where(status: "Approved").order(date_close: :asc)}
		scope :ultimos_30_dias, -> {where("date_close >= ?",  30.days.ago)}
		scope :liners, -> {where(privilegio: 1)}
		scope :ultimo_mes, -> {where("date_close > ? ", Date.today.beginning_of_month ) }
		scope :ventas_faltantes, ->{where(status: nil)}
	end
	def is_active?
		self.status == 1
	end
	def has_contract?
		self.contract.present?
	end
	def status?
  		if self.contract.present?
  			if self.status.present?
  				return self.status
  			else
  				return "Contract Created"
  			end
  		else
  			return "Without contract" 
  		end
  	end
  	def privilegio?
  		case self.privilegio
		  	when  6
		  		return "Administrator"
		  	when 4
		  		return "Company Administrator"
		  	when 3
		  		return "Group Administrator"
		  	when  2
		  		return "Reception"
		  	when  1
		  		return "Liner"
	  	end
  	end
end