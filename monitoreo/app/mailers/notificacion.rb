class Notificacion < ApplicationMailer
  default from: "\"Notificaciones Rails Bancard\" <notificaciones@bancaradrails.com.py>"
  
  def generar_notificaciones
    cpucharge_quantity = 0
    diskspace_quantity = 0
    #array_users_to_notify = 0
    hash_problema_notificar = Array.new
    hash_cuerpo_email = Hash.new
    @rules = Rule.all.order('priority DESC')  
    @rules.each do |rule|
      cpucharge_quantity = 0
      diskspace_quantity = 0
      #array_users_to_notify = 0
      hash_problema_notificar = []
      start_time = (Time.now.to_time - rule.timeexceed.seconds).to_datetime
        @infos = Info.where("created_at > ?", "#{start_time}").order("server_id ASC").order("created_at DESC")
        infosg = @infos.group(:server_id).count
        infosg.each do |key, value|
          hash_cuerpo_email = {}
          @infos.where(:server_id => key).each do |info|
            if (info.cpucharge > rule.cpuchargeexceed)
              cpucharge_quantity = cpucharge_quantity + 1
            end
            if (info.diskspace < rule.diskspaceexceed)
              diskspace_quantity = diskspace_quantity + 1
            end
          end
          if (value == cpucharge_quantity)
            hash_problema_notificar.push("La carga de CPU superó el #{rule.cpuchargeexceed.to_s}%.")
          end
          if (value == diskspace_quantity)
            hash_problema_notificar.push("El espacio en Disco es inferior a #{rule.diskspaceexceed.to_s} Gbs.")
          end
          if (hash_problema_notificar.length > 0)
            @alerts = Alert.where(:rule_id => rule.id)
            @alerts.each do |alert|
              cuerpo = ''
              hash_cuerpo_email["to"] = alert.user.email
              hash_cuerpo_email["recipient"] = alert.user.name + " " + alert.user.lastname
              server = Server.find(key)              
              hash_cuerpo_email["subject"] = "Alerta de Recursos " + server.name + " - " + server.ip
              if (hash_problema_notificar.length > 1)
                cuerpo = "Se presentan los siguientes inconvenientes:" + "<br>" + "<ul>"
                hash_problema_notificar.each do |var|
                  cuerpo = cuerpo + "<li>" + var + "</li>"
                end
              else
                cuerpo = "Se presenta el siguiente inconveniente:" + "<br>"
                hash_problema_notificar.each do |var|
                  cuerpo = cuerpo + "<li>" + var + "</li>"
                end
              end
              cuerpo = cuerpo + '</ul>' + '<br>' + ' en el equipo <b>' + server.name + '</b> - <b>' + server.ip + '</b>. <b style="color:red">Favor verificar!</b>'
              hash_cuerpo_email["body"] = cuerpo
              Notificacion.enviar_notificacion(hash_cuerpo_email).deliver_now
            end
          end
        end
    end
  end
  
  def probar
    hash_cuerpo_email = Hash.new
    hash_cuerpo_email["to"] = 'marceloruffinelli@gmail.com'
    hash_cuerpo_email["subject"] = 'Mail de Prueba Rails'
    Notificacion.enviar_notificacion(hash_cuerpo_email).deliver_now
  end
  
  layout "mailer"
  
  def enviar_notificacion(email)
    @email = email
    @url  = 'http://10.20.10.47:3000'

    mail(
      to: @email["to"],
      subject: @email["subject"]
    )    
    
  end 
end
