class UsersController < ApplicationController
  layout 'home',only: :forgotpassword
  layout 'default'

  before_action :authenticate, except: [:forgotpassword]

  def about
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = t('users.msg_user_not_found')
      redirect_to home_error_path
    end

  end

  def show

  end

  def change_avatar
    begin
      @user = current_user
      @avatar = Photo.new
      @avatar.photo = params[:file_avatar]
      if @avatar.save
        @user.avatar_url = @avatar.photo.url(:thumb)
        @user.avatar = @avatar
        @user.save
      else
        if @avatar.errors
          flash.now[:error] = @avatar.errors.full_messages.to_sentence(:last_word_connector => ', ');
        else
          flash.now[:error] = t('users.msg_change_avatar_fail')
        end
        respond_to do |format|
          format.js { render action: 'change_avatar_fail' }
          format.html
        end
      end
    rescue Exception => e
      logger.error("change avatar error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('users.msg_change_avatar_fail')
        format.js { render action: 'change_avatar_fail' }
        format.html
      end
    end
  end

  def send_mail
    begin
        email = params[:email]
        name =  params[:name]
        respond_to do |format|
          if Emailer.send_email(email,name).deliver
            format.html { render :show,notice: 'send mail success !' }
            format.json { render :show, status: :created, location: @aes_action }
          else
            format.html { render :show }
            # format.json { render json: @aes_action.errors, status: :unprocessable_entity }
          end
        end
    rescue Exception => e
        logger.error("update_curriculum_detail error: #{e.message}")
        puts e.message
        respond_to do |format|
          flash.now[:error] = 'send mail failed'
          format.html { render :show }
          # format.json { render json: @aes_action.errors, status: :unprocessable_entity }
        end
    end
  end

  def changepassword
    if request.method == 'GET'
      respond_to do |format|
        format.html
      end
    else
      begin
        current_password = params[:current_password]
        password =  params[:password]
        confirm_password =  params[:confirm_password]
        respond_to do |format|
          if !(current_password.length<6 || password.length<6 || confirm_password.length<6 || !confirm_password.eql?(password))
            if user = User.find_by(:id => session[:user_id])
              if !user.nil?
                  if user.hashed_password == User.encrypt_password(current_password, user.salt) && password == confirm_password
                    if user.update_attribute(:hashed_password, User.encrypt_password(password, user.salt))
                      Emailer.send_email_change_password(user).deliver
                      flash.now[:notice] = t('users.msg_change_password_success')
                      format.js {  render partial: 'users/success' }
                    else
                      flash.now[:error] = t('users.msg_change_password_error')
                      format.js { render partial: 'layouts/error' }
                    end
                  else
                    flash.now[:error] = t('users.msg_confirm_information')
                    format.js { render partial: 'layouts/error' }
                  end
              end
            end
          else
            flash.now[:error] = t('users.msg_change_password_minlenght_error')
            format.js { render partial: 'layouts/error' }
          end
        end
      rescue Exception => e
        logger.error("change password error: #{e.message}")
        puts e.message
        respond_to do |format|
          flash.now[:error] = t('users.msg_change_password_error')
          format.js { render partial: 'layouts/error' }
        end
      end
    end
  end

  def resetpassword
      begin
      user = User.find_by(:id => session[:user_id])
      if !user.nil?
        respond_to do |format|
          newpassword = User.generate_password(6)
          if user.update_attribute(:hashed_password, User.encrypt_password(newpassword, user.salt))
            Emailer.send_email_generate_password(user,newpassword).deliver
            flash.now[:notice] = t('users.msg_reset_password_success')
            # format.html { redirect_to home_index_path, notice: 'reset password was successfully created.' }
            format.js { render partial: 'layouts/success' }
          else
            flash.now[:error] = t('users.msg_reset_password_error')
            format.js { render partial: 'layouts/error' }
          end
        end
      else
        respond_to do |format|
          flash.now[:error] = t('users.msg_reset_password_error')
          format.js { render partial: 'layouts/error' }
        end
      end
      rescue Exception => e
        logger.error("Reset password error: #{e.message}")
        puts e.message
        respond_to do |format|
          flash.now[:error] = t('users.msg_reset_password_error')
          format.js { render partial: 'layouts/error' }
        end
      end
  end




end
