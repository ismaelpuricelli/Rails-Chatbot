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

  	entries = data["entry"]
  	entries.each do |e|
  		e["messaging"].each do |m|
  			sender = m["sender"]["id"]
  			text = m["message"]["text"]

  			json_to_send = {"recipient":{"id":"#{sender}"}, {"message":{"text":"#{text}"}}}
  			HTTP.post(data_url, json:json_to_send)
  		end
  	end
  	render 'received_data'
  end

  private
  def data_url 
  	"https://graph.facebook.com/v2.6/me/messages?access_token=" + ENV['MSGR_TOKEN']
  end

end
