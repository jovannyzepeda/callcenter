module FunctionsConcern
	#es para agergar tiposdeusuarios yu permisos
	extend ActiveSupport::Concern
	included do 
		scope :ultimos, ->{order(created_at: :desc)}
		scope :activos, -> {where(eliminado:false).ultimos}
		scope :ventas_aprobadas, -> {where(status: true).order(fecha_cierre: :asc)}
		scope :ultimos_30_dias, -> {where("fecha_cierre >= ?",  30.days.ago)}
		scope :liners, -> {where(privilegio: 1)}
		scope :ultimo_mes, -> {where("fecha_cierre > ? ", Date.today.beginning_of_month ) }
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
		  	when  7
		  		return "Administrator"
		  	when 6
		  		return "Company Administrator"
		  	when 5
		  		return "Group Administrator"
		  	when 4
		  		return "Representante legal"
		  	when 3
		  		return "Reeption"
		  	when  2
		  		return "Abogado"
		  	when  1
		  		return "Liner"
	  	end
  	end
end