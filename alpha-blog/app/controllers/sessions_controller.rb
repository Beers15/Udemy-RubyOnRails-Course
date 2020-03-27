class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "Successfully logged in."
			redirect_to user_path(user)
		else
			flash[:danger] = "Login failed. Please try inputting a valid email and password."
			render 'new', :danger
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out."
		redirect_to root_path
	end
end
