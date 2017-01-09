class UploadsController < ApplicationController
  before_action :autenticacion_root
  Ruta_directorio_archivos = "public/";
  def index
  	@campaign = Campaign.all.map{ |c| [c.nombre, c.id] }
  end
  def create_data 
  	if request.post? 
	  		begin
	  			@usuarios = Contact.asign_to_user(params[:campaign_id])
			    archivo = params[:file_data];
			    nombre = archivo.original_filename
			    directorio = Ruta_directorio_archivos;
			    extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
			    path = File.join(directorio, nombre);
			    archivotemporal = File.open(path, "wb") { |f| f.write(archivo.read) };
				@workbook = Spreadsheet.open(path)
				@worksheet = @workbook.worksheet(0)
				@notice = "Se presentaron errores al almacenar los siguientes clientes\n"
				@active = 0;
				0.upto @worksheet.last_row_index do |index|
				  	row = @worksheet.row(index)
				  	if row[0] 
				  		if(index == 0)
				  			@elements = set_array(row)
				  		else
				  			contacto = Contact.new
				  			if  @elements.index("country")
				  				contacto.country = row[@elements.index("country")]
				  			end
				  			if @elements.index("customer")
				  				contacto.cliente = row[@elements.index("customer")]
				  			end
				  			if @elements.index("mail")
				  				contacto.correo = row[@elements.index("mail")]
				  			end
				  			if @elements.index("phone")
				  				contacto.telefono = row[@elements.index("phone")]
				  			end
				  			if @elements.index("fax")
				  				contacto.fax = row[@elements.index("fax")]
				  			end
				  			if @elements.index("city")
				  				contacto.city = row[@elements.index("city")]
				  			end
				  			if @elements.index("season")
				  				contacto.season = row[@elements.index("season")]
				  			end
				  			if @elements.index("country")
				  				contacto.country = row[@elements.index("country")]
				  			end
				  			if @elements.index("unit size")
				  				contacto.unit_size = row[@elements.index("unit size")]
				  			end
				  			if @elements.index("resort")
				  				contacto.resort = row[@elements.index("resort")]
				  			end
					  		contacto.campaign_id = params[:campaign_id]
							if contacto.save
								usuario = @usuarios.sort_by{|e| e[:number]}.first
								@usuarios.sort_by{|e| e[:number]}.first.number = usuario.number + 1
								ContactUser.save_data(usuario,contacto)
								User.update_number(usuario, usuario.number + 1)
							else
								@active = 1
								@notice = @notice + contacto.cliente + "\n"
							end
						end
					end
				end
				if File.exist?(path)
				    archivotemporal = File.delete(path);
				end
				if @active == 0
					@notice = "Contactos almacenados correctamente"
					redirect_to uploads_path, notice: @notice
				else
					redirect_to uploads_path, notice: @notice
				end

			rescue Exception => e
				archivotemporal = File.delete(path);
    			@notice = "Error al leer archivos valida que sea un XLS y cuente con el mismo orden\na su vez validar que el archivo no tenga fuente cursiva"
				redirect_to uploads_path, notice: e
			end
		end
  end
  def set_array(index)
  	@array = Hash.new
  	index.each_with_index do |element, e|
		@array = @array.merge(e => element.downcase)
	end
	return @array
  end
end
