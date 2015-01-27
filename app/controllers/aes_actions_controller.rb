class AesActionsController < ApplicationController
  layout 'default'
  before_action :authenticate
  before_filter :mentor_required, only: [:edit, :update]
  skip_before_action :verify_authenticity_token

  # GET /aes_actions
  # GET /aes_actions.json
  def index
    @aes_actions = Action.all
  end

  # GET /aes_actions/1
  # GET /aes_actions/1.json
  def show
    if @aes_action
      @object=@aes_action
      curriculum_id=@aes_action.curriculum_id
      @curriculum = Curriculum.find(curriculum_id)
      @materials=Curriculum.get_root_material(curriculum_id)
    else
      flash[:error] = t('msg_access_error')
    end
  end
  # GET /aes_actions/new
  def new
    @aes_action = Action.new
  end

  # GET /aes_actions/1/edit
  def quickedit
    # //TODO: checkrole
    begin

      action_id = BSON::ObjectId.from_string(params[:id])
      object_type = params[:object_type]
      @aes_action = Action.find_by(_id: action_id)
      if @aes_action.nil?
        raise t('curriculum.msg_error_not_permission')
      else
        user_id = BSON::ObjectId.from_string(session[:user_id])
        if !@aes_action.curriculum.mentor_id.eql?(user_id)
          raise t('curriculum.msg_error_not_permission')
        else
          if object_type.nil?
            respond_to do |format|
              format.js {render partial: 'aes_actions/edit'}
              format.html
            end
          else
            render :json => @aes_action
          end
        end
      end

    rescue Exception => e
      render :json => { :text => e, :status => 401 }
    end
  end

  # POST /aes_actions
  # POST /aes_actions.json
  def create
    @aes_action = Action.new(aes_action_params)

    respond_to do |format|
      if @aes_action.save
        format.html { redirect_to @aes_action, notice: 'Aes action was successfully created.' }
        format.json { render :show, status: :created, location: @aes_action }
      else
        format.html { render :new }
        format.json { render json: @aes_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aes_actions/1
  # PATCH/PUT /aes_actions/1.json
  def quickupdate
    begin
      # @material = Material.new(curriculum_params)
      # if !@material.update_attributes(:material_name => @material.material_name, :material_type => @material.material_type_id, :material_url => @material.material_url, :description => @material.description)
      #   respond_to do |format|
      #     flash.now[:error] = t('comments.msg_reply_fail')
      #     format.js { render action: 'reply_fail' }
      #     #format.html
      #   end
      # end
      action_id = BSON::ObjectId.from_string(params[:aes_action][:id])
      action = Action.find_by(:id => action_id)
      if action.nil?
        # if !action.save
        #   respond_to do |format|
        #     if action.errors
        #       flash.now[:error] = action.errors.full_messages.to_sentence(:last_word_connector => ', ')
        #     else
        #       flash.now[:error] = t('action.msg_update_failed')
        #     end
        #     format.js { render partial: 'layouts/error' }
        #     # format.html { render action: 'layouts/error' }
        #   end
        # end
        respond_to do |format|
          flash.now[:error] = t('action.msg_not_found')
          format.js { render partial: 'mentor/error' }
          # format.html { render action: 'layouts/error' }
        end
      else
        if !action.update_attributes(:action_name => normalize_string(params[:aes_action][:action_name]), :description => normalize_string(params[:aes_action][:description]))
          respond_to do |format|
            if action.errors
              flash.now[:error] = action.errors.full_messages.to_sentence(:last_word_connector => ', ')
            else
              flash.now[:error] = t('action.msg_update_failed')
            end
            format.js { render partial: 'mentor/error' }
            # format.html { render action: 'layouts/error' }
          end
        else
          # response
          respond_to do |format|
            flash.now[:notice] = t('action.msg_update_success')
            format.js { render partial: 'mentor/success'}
            # format.html
          end
        end
      end
    rescue Exception => e
      logger.error("Action save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('action.msg_update_failed')
        format.js { render partial: 'mentor/error' }
        # format.html { render action: 'layouts/error' }
      end
    end
  end

  # DELETE /aes_actions/1
  # DELETE /aes_actions/1.json
  def destroy
    @aes_action.destroy
    respond_to do |format|
      format.html { redirect_to aes_actions_url, notice: 'Aes action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aes_action
      @aes_action = Action.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aes_action_params
      params[:aes_action]
    end
  # Description: Normalize String
  # @param: string
  # @return string
  # @throws Exception
  # @author CuongCT
  # Create Date: 13/01/2015
  # Modify Date: 13/01/2015
  def normalize_string(string)
    # pattern = /<script.*?>[\s\S]*<\/script>/
    string = string.gsub("\n",'').strip
    string
  end
end
