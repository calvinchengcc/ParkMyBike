class AuthenticationsController < ApplicationController

	def index
		@authentications = current_user.authentications if current_user
	end

	def create
		auth = request.env["omniauth.auth"]
		current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
		flash[:notice] = "Authentication successfull"
		redirect_to url_for(:controller => :sessions, :action => :profile)
	end


#
#	def destroy
#		@authentication = current_user.authentications.find(params[:id])
#		@authentication.destroy
#		flash[:notice] = "Successfully destroyed authentication"
#		redirect_to root_url
#	end


end