class CallbackController < ApplicationController
  def index
  	if params["hub_verify_token"] == "fbToken"
  		render text: params["hub_challenge"]
  	end
  end

  def received_data
  end
end
