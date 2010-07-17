# encoding: UTF-8
# Source Code Modifications (c) 2010 Laurence A. Lee, 
# See /RUBYJEDI.txt for Licensing and Distribution Terms
class AccountsController < ApplicationController
  layout 'accounts'
  before_filter :ssl_required

  def login
    if request.post?
	      if user = User.authenticate(params[:user_login], params[:user_password])
	        session[:user] = user.id
					flash['notice']  = "Login successful"
	        redirect_back_or_default :action => "welcome"
	      else
	        flash.now['notice']  = "Login unsuccessful"
	        @login = params[:user_login]
	      end
    end
  end
  
  def signup
    redirect_to :action => "login" unless User.count.zero?
    
    @user = User.new(params[:user])
    
    if request.post? and @user.save
      session[:user] = User.authenticate(@user.login, params[:user][:password]).id
      flash['notice']  = "Signup successful"
      redirect_to '/'
    end      
  end  
  
  def logout
    session[:user] = nil
  end
    
  def welcome
  end
  
end
