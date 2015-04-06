class MaterialsController < ApplicationController
  layout 'default'
  before_action :authenticate
  before_filter :mentor_required, only: [:edit, :update]
  skip_before_action :verify_authenticity_token

  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.all
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
    if @material
      @object=@material
      curriculum_id=@material.curriculum_id
      @curriculum = Curriculum.find(curriculum_id)
      @materials=Curriculum.get_root_material(curriculum_id)
    else
      flash[:error] = t('msg_access_error')
    end
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # Description: This method get materials from params
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/17
  # Modify Date:
  def quickedit
    begin

      material_id = BSON::ObjectId.from_string(params[:id])
      object_type = params[:object_type]
      @material = Material.find_by(_id: material_id)
      if @material.nil?
        raise t('curriculum.msg_error_not_permission')
      else
        user_id = BSON::ObjectId.from_string(session[:user_id])
        if !@material.curriculum.mentor_id.eql?(user_id)
          raise t('curriculum.msg_error_not_permission')
        else
          if object_type.nil?
            respond_to do |format|
              format.js {render partial: 'materials/edit'}
              format.html
            end
          else
            render :json => @material
          end
        end
      end
    rescue Exception => e
      render :json => {:message => e.message, :status => 401}
    end
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = Material.new(material_params)

    respond_to do |format|
      if @material.save
        format.html { redirect_to @material, notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # Description: This method update materials to database
  # @param
  # @return
  # @throws Exception
  # @author CuongCT
  # Create Date: 2014/12/17
  # Modify Date:
  # PATCH/PUT /curriculums/1
  # PATCH/PUT /curriculums/1.json
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
      @object_type = 'material'
      material_id = BSON::ObjectId.from_string(params[:material][:id])
      @material = Material.find_by(:id => material_id)
      if @material.nil?
        # if !material.save
        #   respond_to do |format|
        #     if material.errors
        #       flash.now[:error] = material.errors.full_messages.to_sentence(:last_word_connector => ', ')
        #     else
        #       flash.now[:error] = t('material.msg_update_failed')
        #     end
        #     format.js { render partial: 'layouts/error' }
        #     # format.html
        #   end
        # end
        # response
        flash.now[:error] = t('material.msg_not_found')
        respond_to do |format|
          format.js { render partial: 'mentor/error' }
          # format.html
        end
      else
        if !@material.update_attributes(:material_name => normalize_string(params[:material][:material_name]),:material_url => params[:material][:material_url], :description => normalize_string(params[:material][:description]),:material_type => params[:material][:material_type_id],asin: params[:material][:asin])
          respond_to do |format|
            if @material.errors
              flash.now[:error] = @material.errors.full_messages.to_sentence(:last_word_connector => ', ')
            else
              flash.now[:error] = t('material.msg_update_failed')
            end
            format.js { render partial: 'mentor/error' }
            # format.html
          end
        else
          # response
          respond_to do |format|
            flash.now[:notice] = t('material.msg_update_success')
            format.js { render partial: 'mentor/success'}
            # format.html
          end
        end
      end
    rescue Exception => e
      logger.error("Material save error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('material.msg_update_failed')
        format.js { render partial: 'mentor/error' }
        # format.html
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def test_edit
    file = File.join(Rails.root, 'app', 'views','emailer','send_email.html.erb')
    if request.method == 'GET'
      @email =  File.read(file)
    else

      # File.open(file, "w+") do |f|
      #   f.write(params[:email_edit])
      # end

      File.open(file, 'w') { |file| file.write(params[:email_edit]) }


      render action: 'test_edit'

    end



  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def curriculum_params
    params.require(:material).permit(:id, :material_name, :material_type_id, :material_url, :description)
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
