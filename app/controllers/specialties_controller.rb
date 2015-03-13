class SpecialtiesController < ApplicationController
  before_action :set_specialty, only: [:show, :edit, :update, :destroy]

  # GET /specialties
  # GET /specialties.json
  def index
    @specialties = Specialty.all
  end

  # GET /specialties/1
  # GET /specialties/1.json
  def show
  end

  # GET /specialties/new
  def new
    @specialty = Specialty.new
  end

  # GET /specialties/1/edit
  def edit
    if @specialty.nil?
      flash.now[:error] = t('specialties.msg_specialty_not_found')
      respond_to do |format|
        format.js { render action: 'edit_fail', :not_found => true }
      end
    end
  end

  # POST /specialties
  # POST /specialties.json
  def create
    begin
      @specialty = Specialty.new(specialty_params)
      @specialty.user_id = session[:user_id]


      if @specialty.save
        flash.now[:notice] = t('specialties.msg_create_successfully')
        respond_to do |format|
          format.html { redirect_to @specialty, notice: t('specialties.msg_create_successfully') }
          format.json { render :show, status: :created, location: @specialty }
          format.js
        end
      else
        if @specialty.errors
          flash.now[:error] = @specialty.errors.full_messages.to_sentence(:last_word_connector => ', ');
        else
          flash.now[:error] = t('specialties.msg_create_fail')
        end
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @specialty.errors, status: :unprocessable_entity }
          format.js { render action: 'create_fail' }
        end
      end

    rescue Exception => e
      logger.error("specialty save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('specialties.msg_create_fail')
        format.js { render action: 'create_fail' }
        format.html
      end
    end
  end

  # PATCH/PUT /specialties/1
  # PATCH/PUT /specialties/1.json
  def update
    begin
      if @specialty.nil?
        flash.now[:error] = t('specialties.msg_specialty_not_found')
        respond_to do |format|
          format.js { render action: 'update_fail' }
        end
      else
        if @specialty.update(specialty_params)
          respond_to do |format|
            format.html { redirect_to @specialty, notice: t('specialties.msg_update_successfully') }
            format.json { render :show, status: :ok, location: @specialty }
            format.js
          end
        else
          if @specialty.errors
            flash.now[:error] = @specialty.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('specialties.msg_update_fail')
          end
          respond_to do |format|
            format.html { render :edit }
            format.json { render json: @specialty.errors, status: :unprocessable_entity }
            format.js { render action: 'update_fail' }
          end
        end
      end
    rescue Exception => e
      logger.error("specialty save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('specialties.msg_update_fail')
        format.js { render action: 'update_fail' }
        format.html
      end
    end
  end

  # DELETE /specialties/1
  # DELETE /specialties/1.json
  def destroy
    begin
      if @specialty.nil?
        flash.now[:error] = t('specialties.msg_specialty_not_found')
        respond_to do |format|
          format.js { render action: 'destroy_fail' }
        end
      else
        if @specialty.destroy
          respond_to do |format|
            format.html { redirect_to work_experiences_url, notice: t('specialties.msg_delete_successfully') }
            format.json { head :no_content }
            format.js
          end
        else
          if @specialty.errors
            flash.now[:error] = @specialty.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('specialties.msg_delete_fail')
          end

          respond_to do |format|
            format.js { render action: 'destroy_fail' }
          end
        end
      end
    rescue Exception => e
      logger.error("specialty save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('specialties.msg_delete_fail')
        format.js { render action: 'destroy_fail' }
        format.html
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specialty
      @specialty = Specialty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def specialty_params
      if params[:specialty][:specialty]
        params[:specialty][:specialty] = params[:specialty][:specialty].squish
      end

      params.require(:specialty).permit(:specialty, :years_of_experience, :description)
    end
end
