class CallbackController < ApplicationController
protect_from_forgery with: :null_session
  def index
  	if params["hub.verify_token"] == "fbToken"
  		render plain: params["hub.challenge"]
  	end
  end

  def received_data
  	usr_request = request.body.read
  	usr_data = JSON.parse(usr_request)
  	parse_send_msg(usr_data)
  	render 'received_data'
  end

  private

  def parse_send_msg(msg)
  	entries = msg["entry"]
  	entries.each do |e|
  		e["messaging"].each do |m|
  			sender = m["sender"]["id"]
  			text = m["message"]["text"]
  			make_AI_reply(sender, text)
  		end
  	end
  end

  def make_AI_reply(sender, text)
  	reply_msg = text #send text to and AI API and retrieve it
  	reply_to_usr(sender, reply_msg)
  end

  def reply_to_usr(usrId, text)
  	json_to_send = {"recipient":{"id":"#{usrId}"}, "message":{"text":"#{text}"}}
  	HTTP.post(data_url, json:json_to_send)
  end

  def data_url 
  	"https://graph.facebook.com/v2.6/me/messages?access_token=" + ENV['MSGR_TOKEN']
  end

end
