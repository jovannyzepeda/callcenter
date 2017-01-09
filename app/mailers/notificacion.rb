class Notificacion < ApplicationMailer
  default from: "zepeda.roque32@gmail.com"
  def send_email(content,client)
    @content = content
    @client = client
    if @content.attachment.present?
	    url = "public"+"#{@content.attachment.url}"
		  url = url[0..-12]
	    attachments["#{@content.attachment_file_name}"] = File.read(url)
	  end
    mail(to: "#{@content.email}", subject: "#{@content.title}")
  end
  def bienvenida(user,pass)
    @user = user
    @pass = pass
    mail(to: "#{@user.email}", subject: "Welcome")
  end
end
