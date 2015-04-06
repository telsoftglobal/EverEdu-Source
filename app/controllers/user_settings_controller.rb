class UserSettingsController < ApplicationController
  layout 'default'
  before_action :authenticate,except: [:change_language]
  # Description: Setting page
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 20150403
  # Modify Date:
  def settings
    @user = User.find(session[:user_id]);
  end

  # Description: get Partial language
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 20150403
  # Modify Date:
  def language_show
      id = BSON::ObjectId.from_string(session[:user_id])
      @user  = User.find_by(id: id )
      render partial: 'user_settings/language/show_get'
  end

  # Description: get Form change language
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 20150403
  # Modify Date:
  def language_form
    if request.method == 'GET'
      @user  = User.find_by(id: BSON::ObjectId.from_string(session[:user_id]) )
      render partial: 'user_settings/language/form_get'
    else
      begin
        locale = params[:user][:language]
        if Language.find_by(id:locale).nil?
          locale = session[:locale]
        end
        user  = User.find_by(id: BSON::ObjectId.from_string(session[:user_id]) )
        user.update_attributes(language:locale)
        session[:locale] = locale
      rescue Exception => e
        flash.now[:error] = t('settings.msg_change_language_error')
      ensure
        redirect_to settings_path
      end
    end
  end

  # Description: change language
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 20150403
  # Modify Date:
  def change_language
      begin
        locale = params[:language]
        if Language.find_by(id:locale).nil?
          locale = I18n.default_locale
        end
        session[:locale] = locale
      rescue Exception => e
        flash.now[:error] = t('settings.msg_change_language_error')
      ensure
        redirect_to home_index_path
      end
  end


end
