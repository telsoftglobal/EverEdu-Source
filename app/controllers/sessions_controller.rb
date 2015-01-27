# Class Name: SessionsController
# Description: This class processes sign up, sign in, sign out functions
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014


class SessionsController < ApplicationController
  layout 'home'

  # Description: this method processes sign in request,
  #              redirect to user's home page if success else render sign in with errors
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 14/10/2014
  # Modify Date:

  def signin
    if signin?
      redirect_to_home_page(@current_user)
    else
      if request.get?
      else
        email = params[:email]
        password = params[:password]
        @user = User.authenticate(email, password)
        if !@user.nil?
          # 20141211: HuyenDT change
          # session[:user_id] = @user.id
          start_user_session(@user)
          @current_user = @user

          #redirect user's home page
          redirect_to_home_page(@current_user)
        else
          flash.now[:error] = t('signin.msg_signin_fail')
          render :signin
        end
      end
    end
  end

  # Description: This method processes sign up request,
  #              redirect to user's home page if success else render sign in with errors
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 14/10/2014
  # Modify Date:
  def signup
    if signin?
      redirect_to_home_page(@current_user)
    else
      #if request's method = get
      if request.get?
        @user = User.new
      else
        #if request's method = post
        @user = User.new(user_params) # new user with user_params
        @user.roles = [Role.get_role_default] #default role is Student

        # save user into database
        if @user.save
          #if user save successful then store id
          # 20141211: HuyenDT change
          # session[:user_id] = @user.id
          start_user_session(@user)
          @current_user = @user

          #redirect student home page
          redirect_to welcome_path
        else
          render :signup
        end
      end
    end
  end

  # Description: This method processes sign out request,
  #              redirect to sign in page
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 14/10/2014
  # Modify Date:
  def signout
    #clear params in session
    session[:user_id] = nil
    @current_user = nil

    #reset session
    request.reset_session

    #redirect to sign in page
    redirect_to signin_path
  end



  def forgot
    if request.post?
      begin
        email = params[:forgot_email]
        user = User.find_by(:email => email)
        respond_to do |format|
          if !user.nil?
            # respond_to do |format|
            newpassword = User.generate_password(6)
            if user.update_attribute(:hashed_password, User.encrypt_password(newpassword, user.salt))
              Emailer.send_email_generate_password(user,newpassword).deliver
              format.html { redirect_to signin_path, notice: t('users.msg_forgot_password_success') }
            else
              flash.now[:error] = t('users.msg_forgot_password_error')
              format.html
            end
          else
            flash.now[:error] = t('users.msg_forgot_password_error')
            format.html
          end
        end
      rescue Exception => e
        logger.error("Forgot password error: #{e.message}")
        respond_to do |format|
          flash.now[:error] = t('users.msg_forgot_password_error')
          format.html
        end
      end
    end
  end

  private
  #return user params
  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation)
  end

end
