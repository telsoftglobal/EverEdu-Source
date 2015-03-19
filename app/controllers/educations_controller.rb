class EducationsController < ApplicationController
  before_action :authenticate
  before_action :set_education, only: [:show, :edit, :update, :destroy]
  layout 'default'

  COUNT_EDUCATION_DISPLAY = 6

  # GET /educations
  # GET /educations.json
  def index
    # @educations = Education.all
    @educations = @current_user.educations.order_by(start_year: -1)
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
  end

  # GET /educations/1/edit
  def edit
    if @education.nil?
      flash.now[:error] = t('education.msg_education_not_found')
      respond_to do |format|
        format.js { render action: 'edit_fail', :not_found => true }
      end
    end
  end

  # POST /educations
  # POST /educations.json
  def create
    begin
      @education = Education.new(education_params)
      @current_user.educations << @education
      if @education.errors && !@education.errors.messages.empty?
        flash.now[:error] = @education.errors.full_messages.to_sentence(:last_word_connector => ', ');
        respond_to do |format|
          # format.html { render :new }
          format.js { render action: 'create_fail' }
        end
      else
        respond_to do |format|
          format.js
          format.html { redirect_to @education, notice: t('education.msg_create_successfully') }
          format.json { render :show, status: :created, location: @education }
          # format.js
        end
      end
    rescue Exception => e
      logger.error("education save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('education.msg_create_fail')
        format.js { render action: 'create_fail' }
        format.html
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    begin
      if @education.nil?
        flash.now[:error] = t('education.msg_education_not_found')
        respond_to do |format|
          format.js { render action: 'update_fail' }
        end
      else
        @education.update_attributes(education_params)

        if @education.errors && !@education.errors.messages.empty?
          flash.now[:error] = @education.errors.full_messages.to_sentence(:last_word_connector => ', ');
          respond_to do |format|
            format.js { render action: 'update_fail' }
            format.html { render :edit }
            format.json { render json: @education.errors, status: :unprocessable_entity }
          end
        else
          respond_to do |format|
            format.js
            format.html { redirect_to @education, notice: t('education.msg_update_successfully') }
            format.json { render :show, status: :ok, location: @education }
          end
        end
      end
    rescue Exception => e
      logger.error("education save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('education.msg_update_fail')
        format.js { render action: 'update_fail' }
        format.html
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    begin
      if @education.nil?
        flash.now[:error] = t('education.msg_education_not_found')
        respond_to do |format|
          format.js { render action: 'destroy_fail' }
        end
      else
        @current_user.educations.delete(@education)

        if @education.errors && !@education.errors.messages.empty?
          flash.now[:error] = @education.errors.full_messages.to_sentence(:last_word_connector => ', ');
          respond_to do |format|
            format.js { render action: 'destroy_fail' }
          end
        else
          respond_to do |format|
            format.js
            format.html { redirect_to work_experiences_url, notice: t('education.msg_delete_successfully') }
            format.json { head :no_content }
          end
        end
      end
    rescue Exception => e
      logger.error("education save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('education.msg_delete_fail')
        format.js { render action: 'destroy_fail' }
        format.html
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      @education = @current_user.educations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def education_params
      params.require(:education).permit(:school_name, :school_url, :start_year, :graduation_year, :field_of_study, :grade, :activities_societies, :description, :app_param_id)
    end
end
