class RoadmapController < ApplicationController
  layout 'default'
  before_action :authenticate
  before_action :set_user_category, only: [:update, :delete]
  ITEM_PER_PAGE = 5

  # Description: This method processes create roadmap
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 2014/12/04
  # Modify Date:
  def create
    begin
      category_id = params[:category_id]
      level_id = params[:level_id]
      @user_category = UserCategory.new(user_id: session[:user_id],category_id: category_id,level_id: level_id)
      if !@user_category.save
        if @user_category.errors
          flash.now[:error] = @user_category.errors.full_messages.to_sentence(:last_word_connector => ', ')
        else
          flash.now[:error] = t('roadmap.msg_create_roadmap_fail')
        end
        respond_to do |format|
          format.js { render partial: 'layouts/error' }
          format.html
        end
      else
        respond_to do |format|
          format.js
          format.html
        end
      end
    rescue Exception => e
      logger.error("Create roadmap error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('roadmap.msg_create_roadmap_fail')
        format.js { render partial: 'layouts/error' }
        format.html
      end
    end
  end

  # Description: This method processes get list roadmaps
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 2014/12/04
  # Modify Date:
  def index
    @levels = Level.where(category_id: params[:category_id])
    last_roadmap_id = params[:last_roadmap_id]
    @user_categories = UserCategory.get_more_roadmaps(session[:user_id], last_roadmap_id)
    @total_roadmaps = UserCategory.where(user_id: session[:user_id]).count()
  end

  # Description: This method processes get levels of category
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 2014/12/04
  # Modify Date:
  def update_levels
    @levels = Level.where(category_id: params[:category_id]).order(level_order: 1)
    respond_to do |format|
      format.js
    end
  end

  # Description: This method processes get more roadmaps
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 2014/12/04
  # Modify Date:
  def get_more_roadmap
    begin
      @total_roadmaps = UserCategory.where(user_id: session[:user_id]).count()
      last_roadmap_id = params[:last_roadmap_id]
      # if last_roadmap_id
      #   last_roadmap_id = BSON::ObjectId.from_string(last_roadmap_id)
      # end
      @user_categories = UserCategory.get_more_roadmaps(session[:user_id], last_roadmap_id)
        respond_to do |format|
          format.js
          format.html
        end
    rescue Exception => e
      logger.error("get_more_roadmaps error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('roadmap.msg_get_more_roadmaps_fail')
        format.js { render partial: 'layouts/error' }
      end
    end
  end

  # Description: This method processes update roadmap
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 2014/12/22
  # Modify Date:
  def update
    begin
      # roadmap_id = params[:roadmap_id]
      level_id = params[:level_id]
      # @user_category = UserCategory.find_by(id: roadmap_id)
      if @user_category.nil?
        flash.now[:error] = t('roadmap.msg_roadmap_notfound')
        respond_to do |format|
          format.js { render partial: 'layouts/error' }
        end
      else
        if @user_category.update_attributes(:level_id => level_id)
          respond_to do |format|
            format.js
            format.html
          end
        else
          if @user_category.errors
            flash.now[:error] = @user_category.errors.full_messages.to_sentence(:last_word_connector => ', ')
          else
            flash.now[:error] =  t('roadmap.msg_update_roadmap_fail')
          end

          respond_to do |format|
            format.js {render action: 'layouts/error'}
            format.html
          end
          end
      end

    rescue Exception => e
      logger.error("update roadmap error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('roadmap.msg_update_roadmap_fail')
        format.js { render partial: 'layouts/error' }
      end
    end
  end

  # Description: This method processes delete roadmap
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 2014/12/04
  # Modify Date:
  def delete
    begin
      # roadmap_id = params[:roadmap_id]
      # @user_category = UserCategory.find_by(id: roadmap_id)
      if @user_category.nil?
        flash.now[:error] = t('roadmap.msg_roadmap_notfound')
        respond_to do |format|
          format.js { render partial: 'layouts/error' }
        end
      else
        if @user_category.destroy
          respond_to do |format|
            # format.html { redirect_to work_experiences_url, notice: t('work_experiences.msg_delete_successfully') }
            format.html
            format.js
          end
        else
          if @user_category.errors
            flash.now[:error] = @user_category.errors.full_messages.to_sentence(:last_word_connector => ', ')
          else
            flash.now[:error] =  t('roadmap.msg_delete_roadmap_fail')
          end

          respond_to do |format|
            format.js {render action: 'layouts/error'}
          end
        end
      end
    rescue Exception => e
      logger.error("Delete roadmap error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('roadmap.msg_delete_roadmap_fail')
        format.js { render partial: 'layouts/error' }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_category
    @user_category = UserCategory.find(params[:roadmap_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_category_params
    params.require(:user_category).permit(:category_id, :level_id)
  end

end


