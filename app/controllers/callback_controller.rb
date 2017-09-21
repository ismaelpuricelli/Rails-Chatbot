class CallbackController < ApplicationController
  def index
  	if params["hub.verify_token"] == "fbToken"
  		#render text: params["hub.challenge"]
  		render text: "notmatch"
  	else
  		render text: "Unmatch"
  	end
  end

  def received_data
  end
end
