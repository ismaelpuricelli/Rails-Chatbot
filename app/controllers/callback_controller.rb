class CallbackController < ApplicationController
  def index
  	if params["hub.verify_token"] == "fbToken"
  		render text: params["hub.challenge"]
  	end
  end

  def received_data
  end
end
