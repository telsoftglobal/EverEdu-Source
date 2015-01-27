# Class Name: SnsSessionController
# Description: The class is description about SNS Session controller and sign in and sign up by sns account methods
# Version: 1.0
# Copyright: Telsoft
# Author: HaPT
# Create Date: 29/10/2014
# Modify Date:

class SnsSessionsController < ApplicationController
  layout "home"
  skip_before_filter :verify_authenticity_token

  # Description: Get sns account and check auth, email to process sign in or sign up
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:

  def create
    if signin?
      redirect_to_home_page(@current_user)
    else
      sns_account = SnsAccount.new
      auth = request.env["omniauth.auth"]
      sns_account.provider = auth['provider']
      sns_account.uid = auth['uid']
      sns_account.user_name = auth['info']['nickname']
      sns_account.first_name = auth['info']['first_name']
      sns_account.last_name = auth['info']['last_name']
      sns_account.email = auth['info']['email']
      sns_account.image_url = auth['info']['image']
      sns_account.access_token = auth['credentials']['token']
      #check provider and uid
      @user = User.find_by('sns_accounts.provider' => sns_account.provider, 'sns_accounts.uid' => sns_account.uid)
      if @user.nil? #sns account not exist
        #check email exist?
        # 20141211: HuyenDT change
        # @user = User.find_by(email: sns_account.email)
        @user = User.find_by_email(sns_account.email)
        if @user.nil? #email not exist
          #create new user
          @user = User.new
          @user.user_name = sns_account.user_name
          @user.first_name = sns_account.first_name
          @user.last_name = sns_account.last_name
          @user.email = sns_account.email
          @user.sns_accounts = [sns_account]
          #redirect to signup page
          render :action => :signup_sns
        else #email existed
          #add sns_account into user
          # @user.update_attributes('update_time' => Time.now, sns)
          @user.sns_accounts.push(sns_account)
          #call sign in
          signin_sns
        end
      else #sns account existed
        #update snsAccount
        # sns_account_exist = @user.sns_accounts.find_by('provider' => sns_account.provider, 'uid' => sns_account.uid)
        # sns_account_exist.update_attributes('user_name' => sns_account.user_name, 'first_name' => sns_account.first_name,
        #                                     'last_name' => sns_account.last_name, 'email' => sns_account.email,
        #                                     'image_url' => sns_account.image_url)
        #call sign in
        signin_sns
      end
    end
  end

  # Description: sign up sns account
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  def signup_sns
    if signin?
      redirect_to_home_page(@current_user)
    else
      if request.post?
        @user = User.new(user_params)
        @user.roles = [Role.get_role_default]
        @user.avatar_url = @user.sns_accounts[0]['image_url']
        if @user.save
          #if user save successful then store id and user information into session
          #reset_session()
          request.reset_session()
          # 20141211: HuyenDT change
          # session[:user_id] = @user.id
          start_user_session(@user)
          @current_user = @user
          logger.debug "Create user user: #{ @user.user_name}"
          #redirect to student page
          redirect_to welcome_path
        else
          render :signup_sns
        end
      end
    end
  end

  # Description: Sign In sns account
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  def signin_sns
    if signin?
      redirect_to_home_page(@current_user)
    else
      #create session
      # session[:user_id] = @user.id
      # 20141211: HuyenDT change
      # session[:user_id] = @user.id
      start_user_session(@user)
      @current_user = @user
      logger.debug "Sign in: #{ @user.user_name}"
      #redirect to user page
      redirect_to_home_page(@current_user)
    end
  end

  # Description: Definition user params to transmit sign up page
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email,
                                 :sns_accounts_attributes => [:provider, :uid, :user_name,
                                                              :first_name, :last_name, :email, :image_url, :access_token])
  end


end
