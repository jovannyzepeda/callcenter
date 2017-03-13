module PermissionsConcern
	#es para agergar tiposdeusuarios yu permisos
	extend ActiveSupport::Concern
	def is_vendor?
		self.privilegio >= 1
	end
	def is_abogado?
		self.privilegio >= 2
	end
	def is_recepcion?
		self.privilegio >= 3
	end
	def is_representante?
		self.privilegio >= 4
	end
	def is_admingroup?
		self.privilegio >= 5
	end
	def is_adminempresa?
		self.privilegio >= 6
	end
	def is_admin?
		self.privilegio >= 7
	end
end 