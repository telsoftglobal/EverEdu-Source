class UsersController < ApplicationController
  layout 'home',only: :forgotpassword
  layout 'default'

  before_action :authenticate, except: [:forgotpassword]
  #before_action :is_my_user, only: [:profile]

  # Description: this method check my user
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 20150309
  # Modify Date:
  def is_my_user
    if params[:id].nil?
      flash[:error] = t('msg_access_error')
      redirect_to home_error_path
    else
      if params[:id].to_s != session[:user_id].to_s
        flash[:error] = t('msg_access_error')
        redirect_to home_error_path
      end
    end
  end

  def about
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = t('users.msg_user_not_found')
      redirect_to home_error_path
    end

  end

  def profile
    @user = User.find(session[:user_id]);
    @history_jobs = @user.history_jobs.order_by(current:-1,end_time: -1, start_time: -1).limit(HistoryJobsController::COUNT_JOB_DISPLAY)
    @educations = @user.educations.order_by(start_year: -1).limit(EducationsController::COUNT_EDUCATION_DISPLAY)
    @specialties = @user.specialties.limit(6)
  end

  def show
    if session[:user_id] == params[:id]
      redirect_to users_profile_path
    else
      @user = User.find(params[:id])
      @history_jobs = @user.history_jobs.order_by(current:-1,end_time: -1, start_time: -1)
      @specialties = @user.specialties
    end
  end

  # Description: this method processes change avatar of user
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 20150309
  # Modify Date:
  def change_avatar
    begin
      @user = User.find(session[:user_id]);
      @avatar = Photo.new
      @avatar.photo = params[:file_avatar]
      if @avatar.save
        @user.avatar_url = @avatar.photo.url(:avatar)
        @user.avatar = @avatar
        @user.save
      else
        if @avatar.errors
          # remove duplicate error message
          if @avatar.errors[:photo]
            @avatar.errors[:photo].each do |error|
              existed = false
              if @avatar.errors.messages[:photo_file_size] && @avatar.errors.messages[:photo_file_size].include?(error)
                existed = true
              end

              if @avatar.errors.messages[:photo_file_type] && @avatar.errors.messages[:photo_file_type].include?(error)
                existed = true
              end

              if !existed
                @avatar.errors.messages[:photo_content] = Array.new
                @avatar.errors.messages[:photo_content] << t('paperclip.errors.invalid_content')
                break
              end
            end
          end
          @avatar.errors.messages[:photo] = nil
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

  def show_user_profile
    id = BSON::ObjectId.from_string(session[:user_id])

    @user  = User.find_by(id: id )
    render partial: 'users/show_user_profile'
  end
  # Description: this method processes update user basic information
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 20150309
  # Modify Date:
  def update_user_profile
    begin
      if request.method == 'GET'
        id = BSON::ObjectId.from_string(session[:user_id])
        @user  = User.find_by(id: id )
        render action: 'form_update_user_basic_information'
      else
        email = params[:user][:email]
        first_name = params[:user][:first_name]
        last_name = params[:user][:last_name]
        if email.nil? || email=='' || first_name.nil? || first_name=='' || last_name.nil? || last_name==''
        #   messgae empty
          flash.now[:error] = t('users.msg_empty_field')
          render partial: 'users/update_basic_information/update_fail'
        else
          gender = params[:user][:gender]
          gender = (gender.nil? || gender=='') ? nil : gender
          # day = Date.new(params[:user][:birth_day][:f])
          if params[:user]['birth_day(1i)'].nil? || params[:user]['birth_day(1i)']=='' || params[:user]['birth_day(2i)'].nil? || params[:user]['birth_day(2i)']=='' || params[:user]['birth_day(3i)'].nil? || params[:user]['birth_day(3i)']==''
            birth_day = nil
          else
            birth_day = Date.new(params[:user]['birth_day(1i)'].to_i,params[:user]['birth_day(2i)'].to_i,params[:user]['birth_day(3i)'].to_i)
            if birth_day > Time.now
              flash.now[:error] =  t('users.msg_verify_data')
              render partial: 'users/update_basic_information/update_fail'
            end
          end
          phone_number = params[:user][:phone_number]
          address = params[:user][:address]
          city = params[:user][:city]
          introduction = params[:user][:introduction]
          if email.length>100 || first_name.length>50 || last_name.length>50 || phone_number.length>25 || address.length>100 || city.length>100 || introduction.gsub("\n",'').strip.length>2000
            flash.now[:error] = t('users.msg_verify_data')
            render partial: 'users/update_basic_information/update_fail'
          else
            id = BSON::ObjectId.from_string(session[:user_id])
            @user  = User.find_by(id: id )
            if params[:user][:country].nil? || params[:user][:country]==''
              country = nil
            else
              country = Country.find_by(id: params[:user][:country])
            end
            if(@user.email!=params[:user][:email])
              if User.find_by(email: params[:user][:email]).nil?
                if params[:user][:password_confirmation].nil? || params[:user][:password_confirmation]=='' || @user.hashed_password != User.encrypt_password(params[:user][:password_confirmation], @user.salt)
                  flash.now[:error] = t('users.msg_empty_or_wrong_password')
                  render partial: 'users/update_basic_information/update_fail'
                else
                  #   update email
                  if @user.update_attributes(email: email.strip, first_name: first_name.strip, last_name: last_name.strip, gender: gender, birth_day: birth_day, phone_number: phone_number.strip,  address: address.strip, city: city.strip, country: country, introduction: introduction.gsub("\n",'').strip )
                    flash[:now] = t('users.msg_update_success')
                    render partial: 'users/update_basic_information/update_success'
                  else
                    flash.now[:error] = t('users.msg_update_failed')
                    render partial: 'users/update_basic_information/update_success'
                  end
                end
              else
              #  mes trung mail
                flash.now[:error] = t('users.msg_email_exist')
                render partial: 'users/update_basic_information/update_fail'
              end
            else
              # / khong update email
              if @user.update_attributes(first_name: first_name.strip, last_name: last_name.strip, gender: gender, birth_day: birth_day, phone_number: phone_number.strip,  address: address.strip, city: city.strip, country: country, introduction: introduction.gsub("\n",'').strip )
                flash[:now] = t('users.msg_update_success')
                render partial: 'users/update_basic_information/update_success'
              else
                flash.now[:error] = t('users.msg_update_failed')
                render partial: 'users/update_basic_information/update_fail'
              end
            end
            User.process_when_update(@user)
            end
        end
      end
    rescue Exception => e
      flash.now[:error] = t('users.msg_update_failed')
      render partial: 'users/update_basic_information/update_fail'
    end
  end

end
