class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_locale
  helper_method :current_user
  #before_filter :session_expiration

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = I18n.default_locale
  end

  # def default_url_options(options={})
  #   logger.debug "default_url_options is passed options: #{options.inspect}\n"
  #   { locale: I18n.locale }
  # end

  # this method find current user of session
  def current_user
    if @current_user.nil?
      # @current_user = User.current
      if @current_user.nil?
        @current_user = User.find(session[:user_id]) if session[:user_id]
        # User.current = @current_user
      end
    end
    @current_user
  end

  # this method check session is signed in?
  def signin?
    if current_user.nil?
      false
    else
      true
    end
  end

  #check user has role
  def has_role?(user, role_name)
    has_role = false
    if !user.roles.nil?
      user.roles.each do |role|
        if role.name.eql?role_name
          has_role = true
        end
      end
    end

    has_role
  end

  def user_is_mentor?(user)
    has_role?(user, Role::ROLE_MENTOR)
  end

  def user_is_student?(user)
    has_role?(user, Role::ROLE_STUDENT)
  end

  def user_is_admin?(user)
    has_role?(user, Role::ROLE_ADMIN)
  end

  #this method redirect to user's home page: student page, mentor page...
  def redirect_to_home_page(user)
    if user.is_mentor?
      redirect_to curriculums_path
    else
      curriculum_study_progresses = CurriculumStudyProgress.where(student_id: current_user.id)
      if !curriculum_study_progresses.nil? &&curriculum_study_progresses.size() > 0
        redirect_to student_index_path
      else
        redirect_to search_search_curriculum_path
      end
    end
  end

  #this method process authenticate
  def authenticate
    if signin?
      true
    else
      respond_to do |format|
        format.html {redirect_to signin_path}
        format.js {render :js => "window.location.href='#{signin_path}'"}
         format.json {redirect_to signin_path}
        #format.json { render :json => [], :status => :unauthorized }
      end
    end
  end

  def mentor_required
    unless current_user && current_user.is_mentor?
      flash[:error] = t('msg_access_error')
      redirect_to home_error_path
    end
  end

  def student_required
    unless current_user && current_user.is_student?
      flash[:error] = t('msg_access_error')
      redirect_to home_error_path
    end
  end

  # Description: start user session
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/11
  # Modify Date:
  def start_user_session(user)
    session[:user_id] = user.id
    session[:ctime] = Time.now.utc.to_i
    session[:atime] = Time.now.utc.to_i
  end

  # Description: check session expire
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/11
  # Modify Date:
  def session_expiration
    if session[:user_id]
      if session_expired?
        reset_session
        flash[:error] = t("error_session_expired")
        redirect_to signin_url
      else
        session[:atime] = Time.now.utc.to_i
      end
    end
  end

  # Description: session expired?
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/11
  # Modify Date:
  def session_expired?
    # if Setting.session_lifetime?
    #   unless session[:ctime] && (Time.now.utc.to_i - session[:ctime].to_i <= Setting.session_lifetime.to_i * 60)
    #     return true
    #   end
    # end

    if APP_CONFIG['session_expire']
      unless session[:atime] && (Time.now.utc.to_i - session[:atime].to_i <= APP_CONFIG['session_expire'].to_i * 60)
        return true
      end
    end
    false
  end


  def get_errors(object)
    msg_errors = "";
    if object.errors
      msg_errors = @work_experience.errors.full_messages.to_sentence(:last_word_connector => ', ');
    end

    msg_errors
  end
end
