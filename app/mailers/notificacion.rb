class Notificacion <  ApplicationMailer
  def send_email(content,client)
    @content = content
    @client = client
    @company = client.campaign.company
    @pass_mail = Company.decodificar(@company.password)
    if @company.security == "TLS"
      ActionMailer::Base.smtp_settings =  {
        :address              => "#{@company.address}",
        :port                 => @company.port,
        :user_name            => "#{@company.username}",
        :password             => "#{@pass_mail}",
        :enable_starttls_auto => true
      }
    else
      ActionMailer::Base.smtp_settings =  {
        :address              => "#{@company.address}",
        :port                 => @company.port,
        :user_name            => "#{@company.username}",
        :password             => "#{@pass_mail}",
        :ssl => true
      }
    end
    if @content.attachment.present?
	    url = "public"+"#{@content.attachment.url}"
		  url = url[0..-12]
	    attachments["#{@content.attachment_file_name}"] = File.read(url)
	  end
    mail(to: "#{@content.email},#{@company.username}", subject: "#{@content.title}", :from => "#{@company.username}")
  end
  def bienvenida(user)
    ActionMailer::Base.smtp_settings =  {
      :address              => "natasha.rxmx.net",
      :port                 => 465,
      :user_name            => 'recomendaciones@blackdiamondcars.com',
      :password             => 'rbRB//99++',
      :ssl => true
    }
    @user = user
    mail(to: "#{@user.email}", subject: "Welcome", :from => 'recomendaciones@blackdiamondcars.com')
  end
  def cambio(user)
    ActionMailer::Base.smtp_settings =  {
      :address              => "natasha.rxmx.net",
      :port                 => 465,
      :user_name            => 'recomendaciones@blackdiamondcars.com',
      :password             => 'rbRB//99++',
      :ssl => true
    }
    @user = user
    mail(to: "#{@user.email}", subject: "Changes in your account", :from => 'recomendaciones@blackdiamondcars.com')
  end 
end

