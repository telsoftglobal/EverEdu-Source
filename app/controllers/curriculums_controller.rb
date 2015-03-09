class CurriculumsController < ApplicationController
  layout 'default'
  before_action :authenticate
  before_filter :mentor_required, only: [:index, :edit, :update, :destroy,:new,:create]
  #before_action :redirect_show, only: [:show]
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy, :join]
  skip_before_action :verify_authenticity_token
  # before_action do
  #   render layout: false if request.xhr?
  # end

  ITEM_PER_PAGE = 10

  # Description: view list curriculum
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  # GET /curriculums
  # GET /curriculums.json
  def index
    category_id = params[:category_id]
    keyword = params[:keyword]
    if !keyword.nil?
      keyword = keyword.to_s
      keyword = keyword.strip
      keyword = replace_special_character(keyword)
    end
    @curriculums = Curriculum.search_with_pagination_by_mentor(category_id, keyword, session[:user_id], params[:page], ITEM_PER_PAGE)
  end

  def getlevel
    # layout false
    @levels = Level.where(category_id: params[:category_id]).order_by(level_order: 1)
    render json: @levels
  end

  def get_material_types
    @material_types = MaterialType.order_by(show_priority: 1)
    respond_to do |format|
      format.html
    end
  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show
    begin
      if @curriculum
        @object = @curriculum
        if @curriculum.mentor.id == current_user.id
          redirect_to show_curriculum_detail_for_mentor_path(@curriculum)
        else
          study_progress = CurriculumStudyProgress.find_by(curriculum_id: @curriculum.id, student_id: current_user.id);
          if !study_progress.nil?
            redirect_to show_curriculum_detail_for_student_path(@curriculum)
          end
        end
      else
        flash[:error] = t('msg_data_error')
        redirect_to home_error_path
      end
    rescue Exception => e
      logger.error("show curriculum error: #{e.message}")
      flash[:error] = t('join.msg_join_fail')
      redirect_to home_error_path
    end
  end

  def redirect_show
    @curriculum = Curriculum.find(params[:id])

    if @curriculum.mentor.id == current_user.id
      redirect_to show_curriculum_detail_for_mentor_path(@curriculum)
    else
      study_progress = CurriculumStudyProgress.find_by(curriculum_id: @curriculum.id, student_id: current_user.id);
      if !study_progress.nil?
        redirect_to show_curriculum_detail_for_student_path(@curriculum)
      end
    end

  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show_for_student

  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show_for_mentor

  end

  # GET /comment/1
  # GET /comment/1.json
  def comment

  end


  # Description: This method processes join to learn a curriculum
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/11/24
  # Modify Date: 2014/11/25

  # GET /join/1
  # GET /join/1.json
  def join
    #get param
    curriculum_id = BSON::ObjectId.from_string(params[:id])
    user_id = BSON::ObjectId.from_string(session[:user_id])
    begin
      #check curriculum existed
      curriculum = Curriculum.find(curriculum_id)
      if curriculum.nil?
        flash[:error] = t('curriculum.msg_curriculum_not_found')
        redirect_to home_error_path
      elsif curriculum.mentor.id == user_id
        #check user is author of curriculum
        flash[:notice] = t('join.msg_cant_join')
        redirect_to show_curriculum_for_mentor_path(curriculum)
      else
        #check user joined curriculum?
        progress = CurriculumStudyProgress.find_by(curriculum_id: curriculum_id, student_id: user_id)
        if !progress.nil?
          flash[:notice] = t('join.msg_joined')
          redirect_to show_curriculum_detail_for_student_path(curriculum)
        else
          begin
            #save progress
            curriculum_progress = CurriculumStudyProgress.new
            curriculum_progress.student_id = user_id
            curriculum_progress.curriculum_id = curriculum.id
            curriculum_progress.curriculum_name = curriculum.curriculum_name
            # curriculum_progress.start_date = Date.today
            curriculum_progress.start_date = DateTime.now
            curriculum_progress.status = ProgressType::TO_DO
            curriculum_progress.save

            #save material progress tree
            materials = curriculum.get_root_material
            materials.each do |material|
              material_progress = MaterialStudyProgress.new
              material_progress.student_id = user_id
              material_progress.curriculum_id = curriculum.id
              material_progress.material_id = material.id
              material_progress.start_date = DateTime.now
              material_progress.status = ProgressType::TO_DO
              material_progress.curriculum_study_progress = curriculum_progress
              material_progress.save

              #save children
              material.children.each do |child|
                child_material_progress = MaterialStudyProgress.new
                child_material_progress.student_id = user_id
                child_material_progress.curriculum_id = curriculum.id
                child_material_progress.material_id = child.id
                child_material_progress.start_date = DateTime.now
                child_material_progress.status = ProgressType::TO_DO
                child_material_progress.curriculum_study_progress = curriculum_progress
                child_material_progress.parent = material_progress
                child_material_progress.save
              end
            end

            #save material progress
            # curriculum.materials.each do |material|
            #   material_progress = MaterialStudyProgress.new
            #   material_progress.student_id = user_id
            #   material_progress.curriculum_id = curriculum.id
            #   material_progress.material_id = material.id
            #   material_progress.start_date = DateTime.now
            #   material_progress.status = ProgressType::TO_DO
            #   material_progress.curriculum_study_progress = curriculum_progress
            #   material_progress.save
            # end

            #save action progress
            curriculum.actions.each do |action|
              action_progress = ActionStudyProgress.new
              action_progress.student_id = user_id
              action_progress.curriculum_id = curriculum.id
              action_progress.action_id = action.id
              action_progress.start_date = DateTime.now
              action_progress.status = ProgressType::TO_DO
              action_progress.curriculum_study_progress = curriculum_progress
              action_progress.save
            end
            flash[:notice] = t('join.msg_join_successful')
            redirect_to show_curriculum_detail_for_student_path(curriculum)
          rescue Exception => e
            logger.error("Join curriculum error: #{e.message}")
            flash[:error] = t('join.msg_join_fail')
            redirect_to home_error_path
          end
        end
      end
    rescue Exception => e
      logger.error("Join curriculum error: #{e.message}")
      flash[:error] = t('join.msg_join_fail')
      redirect_to home_error_path
    end
  end

  # GET /materials/1
  # GET /materials/1.json
  def materials

  end

  # GET /actions/1
  # GET /actions/1.json
  def actions

  end


  # Description: This method init form to create curriculum
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/24
  # Modify Date: 2014/11/25
  # GET /curriculums/new
  def new
    @curriculum = Curriculum.new
    # @materialdefault = Material.new
    # @material_type = MaterialType.find_by(id: 'book')
    # @materialdefault.material_name =''
    # @materialdefault.material_type = @material_type
    # @materialdefault.description = ''
    # @materialdefault.material_url = ''
    # @materialdefault.parent_id = 1
    # @materialdefault.state = 'new'
    #
    # @curriculum.materials << @materialdefault

  end

  # Description: This method init form to edit curriculum general infor
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/18
  # Modify Date: 2014/12/18
  def quickedit
    begin

      curriculum_id = BSON::ObjectId.from_string(params[:id])
      object_type = params[:object_type]
      @curriculum = Curriculum.find_by(:id => curriculum_id)
      if @curriculum.nil?
        raise t('curriculum.msg_error_not_permission')
      else
        user_id = BSON::ObjectId.from_string(session[:user_id])
        if !@curriculum.mentor_id.eql?(user_id)
          raise t('curriculum.msg_error_not_permission')
        else
          if object_type.nil?
            respond_to do |format|
              format.js { render partial: 'curriculums/edit' }
              format.html
            end
          else
            render :json => @curriculum
          end
        end
      end
    rescue Exception => e
      render :json => {:message => e.message, :text => "a", :status => 401}
    end
  end

  # Description: This method update curriculum infor to DB
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/18
  # Modify Date: 2014/12/18
  def quickupdate
    begin
      curriculum_id = BSON::ObjectId.from_string(params[:curriculum][:id])
      curriculum = Curriculum.find_by(:id => curriculum_id)
      if curriculum.nil?
        flash[:error] = t('curriculum.msg_error_not_permission')
        redirect_to home_error_path
      else
        user_id = BSON::ObjectId.from_string(session[:user_id])
        if !curriculum.mentor_id.eql?(user_id)
          flash[:error] = t('curriculum.msg_error_not_permission')
          redirect_to home_error_path
        else
          if !curriculum.update_attributes(:curriculum_name => normalize_string(params[:curriculum][:curriculum_name]),:summary => normalize_string(params[:curriculum][:summary]), :description => normalize_string(params[:curriculum][:description]))
            respond_to do |format|
              if curriculum.errors
                flash.now[:error] = curriculum.errors.full_messages.to_sentence(:last_word_connector => ', ')
              else
                flash.now[:error] = t('curriculum.msg_update_curriculum_failed')
              end
              format.js { render partial: 'mentor/error' }
              # format.html
            end
          else
            # response
            Curriculum.process_when_update_curriculum(curriculum)
            respond_to do |format|
              flash.now[:notice] = t('curriculum.msg_update_curriculum_succes')
              format.js { render partial: 'mentor/success'}
              # format.html
            end
          end
        end
      end
    rescue Exception => e
      logger.error("Curriculum update error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('curriculum.msg_update_curriculum_failed')
        format.js { render partial: 'mentor/error' }
        # format.html
      end
    end
  end
  # Description: This method init form to edit curriculum categories
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/18
  # Modify Date: 2014/12/18
  def quickeditcategories
    begin
      curriculum_id = BSON::ObjectId.from_string(params[:id])
      @curriculum = Curriculum.find_by(:id => curriculum_id)
      if @curriculum.nil?
        raise t('curriculum.msg_error_not_permission')
      else
        user_id = BSON::ObjectId.from_string(session[:user_id])
        if !@curriculum.mentor_id.eql?(user_id)
          raise t('curriculum.msg_error_not_permission')
        else
          respond_to do |format|
            format.js {render partial: 'curriculums/editcategories'}
            # format.html
          end
        end
      end
    rescue Exception => e
      render :json => {:message => e.message, :text => "a", :status => 401}
    end
  end

  # Description: This method update curriculum categories to DB
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/18
  # Modify Date: 2014/12/18
  def quickupdatecategories
    begin
      curriculum_id = BSON::ObjectId.from_string(params[:curriculum][:id])
      curriculum = Curriculum.find_by(:id => curriculum_id)
      if curriculum.nil?
        flash[:error] = t('curriculum.msg_error_not_permission')
        redirect_to home_error_path
      else
        user_id = BSON::ObjectId.from_string(session[:user_id])
        if !curriculum.mentor_id.eql?(user_id)
          flash[:error] = t('curriculum.msg_error_not_permission')
          redirect_to home_error_path
        else
          categories = get_categories_from_params

          if !categories.nil? && !categories.empty?
            curriculum.curriculum_categories = categories
            respond_to do |format|
              if !curriculum.errors
                flash.now[:error] = curriculum.errors.full_messages.to_sentence(:last_word_connector => ', ')
                format.js { render partial: 'mentor/error' }
                # format.html
              else
                  flash.now[:notice] = t('category.msg_update_success')
                  format.js { render partial: 'mentor/success'}
              end
            end
          else
            respond_to do |format|
              flash.now[:error] =  t('category.msg_atleast_category')
              format.js { render partial: 'mentor/error' }
              # format.html
            end
          end
        end
      end
    rescue Exception => e
      logger.error("Curriculum update error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('material.msg_update_failed')
        format.js { render action: 'mentor/error' }
        # format.html
      end
    end
  end



  # Description: This method init form to edit curriculum
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/24
  # Modify Date: 2014/11/26
  # GET /curriculums/edit/1
  def edit
    if @curriculum.nil?
      flash[:error] = t('curriculum.msg_error_not_permission')
      redirect_to home_error_path
    else
      user_id = BSON::ObjectId.from_string(session[:user_id])
      if !@curriculum.mentor_id.eql?(user_id)
        flash[:error] = t('curriculum.msg_error_not_permission')
        redirect_to home_error_path
      end

      if !@curriculum.materials.nil? || !@curriculum.materials.empty?
        @curriculum.materials.each do |material|
          if !material.state
            material.state = 'update'
          end
        end
      else
        flash[:error] = t('curriculum.msg_error')
        redirect_to home_error_path
      end

      if @curriculum.curriculum_categories.nil? || @curriculum.curriculum_categories.empty?
        flash[:error] = t('curriculum.msg_error')
        redirect_to home_error_path
      end

      if !@curriculum.actions.nil?
        @curriculum.actions.each do |action|
          if !action.state
            action.state = 'update'
          end
        end
      end
    end
  end


  # Description: This method get list material type
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  def get_material_types
    @material_types = MaterialType.order_by(show_priority => 1)
    respond_to do |format|
      format.html
    end
  end


  # Description: This method create curriculum
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  # POST /curriculums
  # POST /curriculums.json
  def create
    begin

    # @curriculum = Curriculum.new(curriculum_params)
    @curriculum = get_curriculum_from_params

    respond_to do |format|
      if save_curriculum(@curriculum)

        format.html { redirect_to @curriculum, notice: t('curriculum.msg_create_curriculum_succes')}
        format.json { render :show, status: :created, location: @curriculum}
      else
        # flash[:error] = []
        # if @curriculum.errors.instance_of?Array
        #   @curriculum.errors.full_messages.each do |message|
        #     flash[:error]=message
        #   end
        # else
        #   flash[:error]<<@curriculum.errors
        # end
        format.html { render :new,notice: flash[:error]}
        format.json { render json: @curriculum.errors, status: :unprocessable_entity}
      end
      # format.html { render :new }
    end
    rescue Exception => e
      # respond_to do |format|
      # logger e.message
      #throw e
      flash[:error] = e.message
      redirect_to home_error_path
      # end
    end
  end

  # Description: This method save curriculum into database
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  def save_curriculum(curriculum)
    #save curriculum


    #save materials
    if !curriculum.materials.nil?
      curriculum.materials.each do |material|
        if !material.save
          flash[:error] = material.errors.full_messages
          return false
        end
      end
    end

    #save actions
    if !curriculum.actions.nil?
      curriculum.actions.each do |action|
        if !action.save
          flash[:error] = action.errors.full_messages
          return false
        end
      end
    end

    if !curriculum.save
      flash[:error] = curriculum.errors.full_messages
      return false
    end
    return true
  end

  # Description: This method update curriculum into database
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  # PATCH/PUT /curriculums/1
  # PATCH/PUT /curriculums/1.json
  def update
    begin
      # @curriculum = get_curriculum_from_params
        respond_to do |format|
          if update_curriculum
            format.html { redirect_to @curriculum, notice: t('curriculum.msg_update_curriculum_succes')}
            format.json { render :show, status: :ok, location: @curriculum}
          else
            if flash[:error].nil?
              flash[:error] = []
            end
            if @curriculum.errors.instance_of?Array
              @curriculum.errors.full_messages.each do |message|
                flash[:error]<<message
              end
            else
              flash[:error]<<@curriculum.errors.full_messages
            end
            format.html { render :edit}
            format.json { render json: @curriculum.errors, status: :unprocessable_entity}
          end
        end

    rescue Exception => e
      # respond_to do |format|
      # logger e.message
      #throw e
      flash[:error] = e.message
      redirect_to home_error_path
      # end
    end
  end

  # Description: This method save curriculum into database
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  # update curriculum into database
  def update_curriculum

    curriculumupdate = Curriculum.find_by(:id => params[:id])
    user_id = BSON::ObjectId.from_string(session[:user_id])
    if curriculumupdate.nil? || !curriculumupdate.mentor_id.eql?(user_id)
      raise t('curriculum.msg_error_not_permission')
    else

      curriculum_name = normalize_string(params[:curriculum][:curriculum_name])
      summary = normalize_string(params[:curriculum][:summary])
      description = normalize_string(params[:curriculum][:description])

      if !curriculumupdate.nil?
        if !curriculumupdate.update_attributes(:curriculum_name => curriculum_name,:summary => summary, :description => description)
          flash[:error] = curriculumupdate.errors.full_messages
          return false
        end
      end



      listmaterial = get_materials_of_curriculum_from_params(curriculumupdate)
      listaction = get_actions_of_curriculum_from_params(curriculumupdate)

      listmaterial.each do |material|
        if material.state.eql?'update'
          materialupdate = Material.find_by(:id => material.id)
          if materialupdate.nil? || !material.curriculum_id.eql?(curriculumupdate.id)
            raise t('curriculum.msg_error_not_permission')
          else
            if !materialupdate.update_attributes(:material_name => material.material_name,:material_url => material.material_url, :description => material.description,:material_type => material.material_type)
              flash[:error] = materialupdate.errors.full_messages
              return false
            end
          end
        else
          # materialnew = Material.new(:material_name => material.material_name,:material_url => material.material_url, :description => material.description,:material_type => material.material_type)
          if !material.save
            flash[:error] = material.errors.full_messages
            return false
          end
        end
      end

      listaction.each do |action|
        if action.state.eql?'update'
          actionupdate = Action.find_by(:id => action.id)
          if actionupdate.nil? || !action.curriculum_id.eql?(curriculumupdate.id)
            raise t('curriculum.msg_error_not_permission')
          else
            if !actionupdate.update_attributes(:action_name => action.action_name, :description => action.description)
              flash[:error] = actionupdate.errors.full_messages
              return false
            end
          end
        else
          if !action.save
            flash[:error] = action.errors.full_messages
            return false
          end
        end
      end
      curriculumupdate.curriculum_categories = get_categories_of_curriculum_from_params

    end

    # curriculumupdate = Curriculum.find_by(:id => curriculum.id)
    # if !curriculumupdate.update(:curriculum_name => curriculum.curriculum_name,:summary => curriculum.summary, :description => curriculum.description)
    #
    #   return false
    # end

    # if !curriculum.curriculum_categories.save
    #   return false
    # end

    Curriculum.process_when_update_curriculum(curriculumupdate)

    return true
  end

  # DELETE /curriculums/1
  # DELETE /curriculums/1.json
  def destroy
    @curriculum.destroy
    respond_to do |format|
      format.html { redirect_to curriculums_url, notice: 'Curriculum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
      if(not @curriculum.nil?)
        @materials=Curriculum.get_root_material(params[:id])
        # @curriculums_of_mentor= Curriculum.where(mentor_id: @curriculum.mentor_id).order_by(created_at: -1).limit(5)
        # @curriculums_top= Curriculum.order_by(created_at: -1).limit(5)
      end
    end
    
# Never trust parameters from the scary internet, only allow the white list through.
  def curriculum_params
    params.require(:curriculum).permit(:curriculum_name, :summary, :status, :description)
  end

  # Description: This method get general_curriculum from params
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
    def get_curriculum_from_params
      begin
      curriculum = Curriculum.new
      if(params[:action].eql?'update')
        curriculum.new_record = false
      else
        curriculum.mentor_id = session[:user_id]
      end
      if !params[:id].nil?
        curriculum._id = BSON::ObjectId.from_string(params[:id] )
      end
      curriculum.curriculum_name = normalize_string(params[:curriculum][:curriculum_name])
      curriculum.summary = normalize_string(params[:curriculum][:summary]).strip
      curriculum.description = normalize_string(params[:curriculum][:description])
      listmaterial = get_materials_of_curriculum_from_params(curriculum)
      listaction = get_actions_of_curriculum_from_params(curriculum)
      if !listmaterial.empty?
        # if curriculum.new_record
          curriculum.materials =  listmaterial
        # else
        #   curriculum.materials <<  listmaterial
        # end
      end

      if !listaction.empty?
        # if curriculum.new_record
          curriculum.actions = listaction
        # else
          # curriculum.actions << listaction
        # end
      end

      curriculum.curriculum_categories = get_categories_of_curriculum_from_params
      curriculum
      # //TODO:  xu ly lai
      rescue Exception => e
        puts e.message
      end
    end


  # Description: This method get materials from params
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  def get_materials_of_curriculum_from_params(curriculum)
    hash_material_ids = Hash.new
    materials = Array.new
    if !params[:curriculum][:materials_attributes].nil?
      params[:curriculum][:materials_attributes].values.each do |material_attributes|
        material = Material.new
        if !material_attributes[:material_id].nil? and material_attributes[:state].eql?'update'
          material._id = BSON::ObjectId.from_string(material_attributes[:material_id])
          material.new_record = false
        end
        material.material_name = normalize_string(material_attributes[:material_name])
        material.material_url = material_attributes[:material_url].strip
        material.material_type_id = material_attributes[:material_type_id]
        material.description = normalize_string(material_attributes[:description])
        material.curriculum = curriculum
        material.state = material_attributes[:state]
        material_id = material_attributes[:material_id]
        parent_id = material_attributes[:parent_id]
        if !parent_id.nil?
          parent = hash_material_ids[parent_id]
          if !parent.nil?
            material.parent = parent
          end
        end
        materials << material
        hash_material_ids[material_id] = material
      end
    end
    materials.each do |materialupdateparent|
      if !materialupdateparent.parent_id.nil?
      parent = hash_material_ids[materialupdateparent.parent_id]
      if !parent.nil?
        materialupdateparent.parent = parent
      end
      end
    end
    materials
  end

  # Description: This method get action from params
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  def get_actions_of_curriculum_from_params(curriculum)
    actions = Array.new
    if !params[:curriculum][:actions_attributes].nil?
      params[:curriculum][:actions_attributes].values.each do |action_attributes|
        action = Action.new
        if !action_attributes[:action_id].nil? and action_attributes[:state].eql?'update'
          action._id = BSON::ObjectId.from_string(action_attributes[:action_id])
          action.new_record=false
        end
        action.action_name = normalize_string(action_attributes[:action_name])
        action.description = normalize_string(action_attributes[:description])
        action.curriculum = curriculum
        action.state = action_attributes[:state]
        actions << action
      end
    end
    actions
  end

  # Description: This method get curriculums_categories from params
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/11/21
  # Modify Date:
  def get_categories_of_curriculum_from_params
    curriculum_categories = Array.new
    if !params[:curriculum][:curriculum_categories_attributes].nil?
      params[:curriculum][:curriculum_categories_attributes].values.each do |category_attributes|
        curriculum_category = CurriculumCategory.new
        curriculum_category.category_id = BSON::ObjectId.from_string(category_attributes[:category_id])
        curriculum_category.category_name = category_attributes[:category_name]
        curriculum_category.level_ids = Array.new
        if !category_attributes[:level_ids].nil?
          category_attributes[:level_ids].values.each do |level_id|
            curriculum_category.level_ids << BSON::ObjectId.from_string(level_id)
          end
        end

        curriculum_categories << curriculum_category
      end
    end
    curriculum_categories
  end

  # Description: This method get categories from params
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/18
  # Modify Date:
  def get_categories_from_params
    curriculum_categories = Array.new
    if !params[:curriculum][:curriculum_categories_attributes].nil?
      params[:curriculum][:curriculum_categories_attributes].values.each do |category_attributes|
        curriculum_category = CurriculumCategory.new
        curriculum_category.category_id = BSON::ObjectId.from_string(category_attributes[:category_id])
        curriculum_category.category_name = category_attributes[:category_name]
        curriculum_category.level_ids = Array.new
        if !category_attributes[:level_ids].nil?
          category_attributes[:level_ids].values.each do |level_id|
            curriculum_category.level_ids << BSON::ObjectId.from_string(level_id)
          end
        end
        curriculum_categories << curriculum_category
      end
    end
    curriculum_categories
  end

  def replace_special_character(string)
    pattern = /(\'|\"|\.|\*|\/|\-|\\|\&|\(|\)|\^|\%|\$|\#|\>|\<|\?|\{|\}|\[|\]|\~|\+)/
    string = string.gsub(pattern){|match|"\\"  + match}
    string
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
    # Description: update content of curriculum detail: when mentor click Curriculum/Matertial/Action
    # @param: curriculum_id, student_id
    # @return action_study_progess  collection
    # @throws Exception
    # @author SonNH
    # Create Date: 04/12/2014
    # Modify Date: 12/12/2014
  def view_detail
    # @object_type = params[:object_type]
    # @curriculum_study_progress = CurriculumStudyProgress.get_curriculum_study_by_id(params[:curriculum_id])
    # if @object_type == 'curriculum'
    #   @object  = @curriculum_study_progress.curriculum
    # elsif @object_type == 'material'
    #   material_study_id = params[:object_id]
    #   @material_study = MaterialStudyProgress.get_material_study_by_id(material_study_id)
    #   @object  = @material_study.material
    # elsif @object_type == 'action'
    #   @action_study = ActionStudyProgress.find_by(_id: params[:object_id])
    #   @object  =  @action_study.action
    # end
    # respond_to do |format|
    #   format.js
    # end
  end

end
