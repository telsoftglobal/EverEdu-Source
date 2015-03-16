class HistoryJobsController < ApplicationController
  before_action :authenticate
  before_action :set_history_job, only: [:show, :edit, :update, :destroy]
  layout 'default'

  COUNT_JOB_DISPLAY = 6

  # GET /history_jobs
  # GET /history_jobs.json
  def index
    # user_id = session[:user_id]
    # @history_jobs = HistoryJob.where(user_id: user_id).order_by(current: -1, end_time: -1, start_time: -1)
    @history_jobs = @current_user.history_jobs.order_by(current: -1, end_time: -1, start_time: -1)
  end

  # GET /history_jobs/1
  # GET /history_jobs/1.json
  def show
  end

  # GET /history_jobs/new
  def new
    @history_job = HistoryJob.new
  end

  # GET /history_jobs/1/edit
  def edit
    if @history_job.nil?
      flash.now[:error] = t('history_job.msg_history_job_not_found')
      respond_to do |format|
        format.js { render action: 'edit_fail', :not_found => true }
      end
    end
  end

  # POST /history_jobs
  # POST /history_jobs.json
  def create
    begin
      @history_job = HistoryJob.new(history_job_params)
      @current_user.history_jobs << @history_job
      if @history_job.errors && !@history_job.errors.messages.empty?
        flash.now[:error] = @history_job.errors.full_messages.to_sentence(:last_word_connector => ', ');
        respond_to do |format|
          # format.html { render :new }
          format.js { render action: 'create_fail' }
        end
      else
        respond_to do |format|
          format.js
          format.html { redirect_to @history_job, notice: t('history_job.msg_create_successfully') }
          format.json { render :show, status: :created, location: @history_job }
          # format.js
        end
      end
    rescue Exception => e
      logger.error("history job save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('history_job.msg_create_fail')
        format.js { render action: 'create_fail' }
        format.html
      end
    end
  end

  # PATCH/PUT /history_jobs/1
  # PATCH/PUT /history_jobs/1.json
  def update
    begin
      if @history_job.nil?
        flash.now[:error] = t('history_job.msg_history_job_not_found')
        respond_to do |format|
          format.js { render action: 'update_fail' }
        end
      else
        @history_job.update_attributes(history_job_params)

        if @history_job.errors && !@history_job.errors.messages.empty?
          flash.now[:error] = @history_job.errors.full_messages.to_sentence(:last_word_connector => ', ');
          respond_to do |format|
            format.js { render action: 'update_fail' }
            format.html { render :edit }
            format.json { render json: @history_job.errors, status: :unprocessable_entity }
          end
        else
          respond_to do |format|
            format.js
            format.html { redirect_to @history_job, notice: t('history_job.msg_update_successfully') }
            format.json { render :show, status: :ok, location: @history_job }
          end
        end
      end
    rescue Exception => e
      logger.error("history job save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('history_job.msg_update_fail')
        format.js { render action: 'update_fail' }
        format.html
      end
    end
  end

  # DELETE /history_jobs/1
  # DELETE /history_jobs/1.json
  def destroy
    begin
      if @history_job.nil?
        flash.now[:error] = t('history_job.msg_history_job_not_found')
        respond_to do |format|
          format.js { render action: 'destroy_fail' }
        end
      else
        @current_user.history_job.delete(@history_job)

        if @history_job.errors && !@history_job.errors.messages.empty?
          flash.now[:error] = @history_job.errors.full_messages.to_sentence(:last_word_connector => ', ');
          respond_to do |format|
            format.js { render action: 'destroy_fail' }
          end
        else
          respond_to do |format|
            format.html { redirect_to work_experiences_url, notice: t('history_job.msg_delete_successfully') }
            format.json { head :no_content }
            format.js
          end
        end
      end
    rescue Exception => e
      logger.error("history_job save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('history_job.msg_delete_fail')
        format.js { render action: 'destroy_fail' }
        format.html
      end
    end
  end


  def update_levels
    @levels = Level.where(category_id: params[:category_id]).order_by(level_order: 1)
    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_history_job
    @history_job = @current_user.history_jobs.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def history_job_params
    params.require(:history_job).permit(:company_name, :title, :location, :start_time, :end_time, :current, :description, :category_id, :level_id, :company_url)
  end
end
