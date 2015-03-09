class WorkExperiencesController < ApplicationController
  layout 'default'
  before_action :authenticate
  before_action :set_work_experience, only: [:show, :edit, :update, :destroy]

  # GET /work_experiences
  # GET /work_experiences.json
  # Description: This method processes list work experiences of user
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/19
  # Modify Date:
  def index
    user_id = session[:user_id]
    @work_experiences = WorkExperience.where(user_id: user_id).order_by(created_at: -1)
  end

  # GET /work_experiences/1
  # GET /work_experiences/1.json
  def show
  end

  # GET /work_experiences/new
  # Description: This method init new work experience
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/19
  # Modify Date:
  def new
    @work_experience = WorkExperience.new
  end

  # GET /work_experiences/1/edit
  # Description: This method processes edit a work experience
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/19
  # Modify Date:
  def edit
    if @work_experience.nil?
      flash.now[:error] = t('work_experiences.msg_work_experience_not_found')
      respond_to do |format|
        format.js { render action: 'edit_fail', :not_found => true }
      end
    end
  end

  # POST /work_experiences
  # POST /work_experiences.json
  # Description: This method processes create a work experience
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/19
  # Modify Date:
  def create
    begin
      @work_experience = WorkExperience.new(work_experience_params)
      @work_experience.user_id = session[:user_id]


      if @work_experience.save
        flash.now[:notice] = t('work_experiences.msg_create_successfully')
        respond_to do |format|
          format.html { redirect_to @work_experience, notice: t('work_experiences.msg_create_successfully') }
          format.json { render :show, status: :created, location: @work_experience }
          format.js
        end
      else

        if @work_experience.errors
          flash.now[:error] = @work_experience.errors.full_messages.to_sentence(:last_word_connector => ', ');
        else
          flash.now[:error] = t('work_experiences.msg_create_fail')
        end
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @work_experience.errors, status: :unprocessable_entity }
          format.js { render action: 'create_fail' }
        end
      end

    rescue Exception => e
      logger.error("work_experience save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('work_experiences.msg_create_fail')
        format.js { render action: 'create_fail' }
        format.html
      end
    end
  end

  # PATCH/PUT /work_experiences/1
  # PATCH/PUT /work_experiences/1.json
  # Description: This method processes update a work experience
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/19
  # Modify Date:
  def update
    begin
      if @work_experience.nil?
        flash.now[:error] = t('work_experiences.msg_work_experience_not_found')
        respond_to do |format|
          format.js { render action: 'update_fail' }
        end
      else
        if @work_experience.update(work_experience_params)
          respond_to do |format|
            format.html { redirect_to @work_experience, notice: t('work_experiences.msg_update_successfully') }
            format.json { render :show, status: :ok, location: @work_experience }
            format.js
          end
        else
          if @work_experience.errors
            flash.now[:error] = @work_experience.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('work_experiences.msg_update_fail')
          end
          respond_to do |format|
            format.html { render :edit }
            format.json { render json: @work_experience.errors, status: :unprocessable_entity }
            format.js { render action: 'update_fail' }
          end
        end
      end
    rescue Exception => e
      logger.error("work_experience save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('work_experiences.msg_update_fail')
        format.js { render action: 'update_fail' }
        format.html
      end
    end
  end

  # DELETE /work_experiences/1
  # DELETE /work_experiences/1.json
  # Description: This method processes delete a work experience
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/19
  # Modify Date:
  def destroy
    begin
      if @work_experience.nil?
        flash.now[:error] = t('work_experiences.msg_work_experience_not_found')
        respond_to do |format|
          format.js { render action: 'destroy_fail' }
        end
      else
        if @work_experience.destroy
          respond_to do |format|
            format.html { redirect_to work_experiences_url, notice: t('work_experiences.msg_delete_successfully') }
            format.json { head :no_content }
            format.js
          end
        else
          if @work_experience.errors
            flash.now[:error] = @work_experience.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('work_experiences.msg_delete_fail')
          end

          respond_to do |format|
            format.js { render action: 'destroy_fail' }
          end
        end
      end
    rescue Exception => e
      logger.error("work_experience save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('work_experiences.msg_delete_fail')
        format.js { render action: 'destroy_fail' }
        format.html
      end
    end
  end

  # Description: This method processes get levels by category
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  def update_levels
    @levels = Level.where(category_id: params[:category_id]).order_by(level_order: 1)
    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_work_experience
    @work_experience = WorkExperience.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def work_experience_params
    if params[:work_experience][:work_place]
      params[:work_experience][:work_place] = params[:work_experience][:work_place].strip
    end

    if params[:work_experience][:description]
      params[:work_experience][:description] = params[:work_experience][:description].strip
    end

    params.require(:work_experience).permit(:category_id, :level_id, :work_place, :start_year, :end_year, :current, :description)
  end

end
