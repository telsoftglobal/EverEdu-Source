# Class Name: SessionsController
# Description: This class processes functions of mentor
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class MentorController < ApplicationController
  layout 'default'

  before_action :authenticate
  before_filter :mentor_required

  def index
  end
  def create
  end

  # Description: This method processes show curriculum of mentor
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/02
  # Modify Date: 2014/01/05

  def show
    @object_type = 'curriculum'
    @curriculum = Curriculum.find(params[:id])
    @object = @curriculum

    if @curriculum
      if @curriculum.mentor.id == current_user.id
        #get material is root
        @materials = Curriculum.get_root_material(params[:id])

        # @material_parents = Material.where(curriculum_id: @curriculum.id, parent_id: nil).order_by(id: 1)
        # @material_children = Material.where(curriculum_id: @curriculum.id, parent_id: nil).order_by(id: 1)

        #get notification of curriculum
        @curriculum_notification = Notification.get_notification_by_object_recipient(Notification::COMMENT_TYPE, Comment::CURRICULUM_TYPE, [@object.id], current_user.id, TRUE)

        #get notification of materials
        material_ids = []
        @curriculum.materials.each do |material|
          material_ids << material.id
        end
        @material_notification = Notification.get_notification_by_object_recipient(Notification::COMMENT_TYPE, Comment::MATERIAL_TYPE, material_ids, current_user.id, TRUE)

        #get notification of actions
        action_ids = []
        @curriculum.actions.each do |action|
          action_ids << action.id
        end
        @action_notification = Notification.get_notification_by_object_recipient(Notification::COMMENT_TYPE, Comment::ACTION_TYPE, action_ids, current_user.id, TRUE)
      else
        flash[:error] = t('msg_access_error')
        redirect_to home_error_path
      end
    else
      flash[:error] = t('curriculum.msg_curriculum_not_found')
      redirect_to home_error_path
    end
  end

  # Description: This method processes update content of curriculum detail: when mentor click Curriculum/Matertial/Action
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 2014/12/02
  # Modify Date: 2014/12/02
  def update_curriculum_detail
    begin
      @object_type = params[:object_type]
      if @object_type == 'curriculum'
        @object = Curriculum.find_by(_id: params[:object_id])
      elsif @object_type == 'material'
        @object = Material.find_by(_id: params[:object_id])
      elsif @object_type == 'action'
        @object = Action.find_by(_id: params[:object_id])
      end

      # update read all notification (new comment)
      current_user.read_all_notification(Notification::COMMENT_TYPE, @object.id, @object.object_type)

      #render response
      respond_to do |format|
        format.js
        format.html
      end
    rescue Exception => e
      logger.error("update_curriculum_detail error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('mentor.curriculums.msg_load_detail_fail')
        format.js
        format.html
      end
    end
  end

end
