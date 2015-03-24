# Class Name: StudentController
# Description: This class processes functions of student
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class StudentController < ApplicationController
  layout 'default'

  before_action :authenticate
  before_filter :student_required

  ITEM_PER_PAGE = 10

  # Description: this method view list curriculum that student joined
  # @param
  # @return
  # @throws Exception
  # @author HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  def index
    keyword = params[:keyword]
    if !keyword.nil?
      keyword = keyword.to_s
      keyword = keyword.strip
      keyword = replace_special_character(keyword)
    end
    @curriculums = CurriculumStudyProgress.search_with_pagination_by_student(keyword, session[:user_id], params[:page], ITEM_PER_PAGE)
    @total_entries = @curriculums.total_entries

    @curriculums.each do |curriculum_study|
      curriculum_study.calculate_progress
    end

  end

  # Description: this method processes become mentor
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  # Create Date: 14/10/2014
  # Modify Date:
  def become_mentor
    if !current_user.nil?
      if !@current_user.is_mentor?
        role = Role.get_role_mentor
        if !role.nil?
          @current_user.roles.push(role)
          redirect_to curriculums_path
        end
      else
        flash[:notice] = "You are already mentor"
      end
    end
  end

  def replace_special_character(string)
    pattern = /(\'|\"|\.|\*|\/|\-|\\|\&|\(|\)|\^|\%|\$|\#|\>|\<|\?|\{|\}|\[|\]|\~|\+)/
    string = string.gsub(pattern){|match|"\\"  + match}
    string
  end
  # Description: show curriculum detail: when mentor click View Detail
  # @param:
  # @return
  # @throws Exception
  # @author SonNH
  # Create Date: 26/11/2014
  # Modify Date: 12/12/2014
  # GET /curriculum_details
  # GET /curriculum_details.json
  def show
    curriculum_id = params[:id]
    user_id = session[:user_id]
    @curriculum_study_progress = CurriculumStudyProgress.get_curriculum_study_curriculum_by_id(curriculum_id, user_id)
    if(not @curriculum_study_progress.nil?)
      @object_type='curriculum'
      @object = @curriculum_study_progress.curriculum
      @material_study_progresses = MaterialStudyProgress.get_material_by_curriculum_study(@curriculum_study_progress._id)
      @total_material_done = 0
      @total_action_done = 0
      @material_study_progresses.each do |item|
        if item.status == ProgressType::DONE
          @total_material_done = @total_material_done + 1
        end
      end
      @action_study_progresses = ActionStudyProgress.where(curriculum_study_progress_id: @curriculum_study_progress._id).order_by(action_id: 1)
      @action_study_progresses.each do |item|
        if item.status == ProgressType::DONE
          @total_action_done = @total_action_done + 1
        end
      end
      @total_material = @material_study_progresses.size()
      @percentage_material = @total_material_done.to_f/@total_material*100
      @total_action = @action_study_progresses.size()
      if @total_action > 0
        @percentage_action = @total_action_done.to_f/@total_action*100
      else
        @percentage_action = 100
      end
    else
      flash[:error] = t('msg_data_error')
      redirect_to home_error_path
    end
  end
  # Description: update content of curriculum detail: when mentor click Curriculum/Matertial/Action
  # @param: curriculum_id, student_id
  # @return action_study_progess  collection
  # @throws Exception
  # @author SonNH
  # Create Date: 04/12/2014
  # Modify Date: 12/12/2014
  def update_curriculum_detail
    @object_type = params[:object_type]
    @curriculum_study_progress = CurriculumStudyProgress.get_curriculum_study_by_id(params[:curriculum_id])
    if @object_type == 'curriculum'
      @object  = @curriculum_study_progress.curriculum
    elsif @object_type == 'material'
      material_study_id = params[:object_id]
      @material_study = MaterialStudyProgress.get_material_study_by_id(material_study_id)
      @object  = @material_study.material
    elsif @object_type == 'action'
      @action_study = ActionStudyProgress.find_by(_id: params[:object_id])
      @object  =  @action_study.action
    end
    respond_to do |format|
      format.js
    end
  end
  # Description: update content of curriculum detail: when mentor click Curriculum/Matertial/Action
  # @param: curriculum_id, student_id, material_id, action_id
  # @return action_study_progess  collection
  # @throws Exception
  # @author SonNH
  # Create Date: 04/12/2014
  # Modify Date: 12/12/2014
  def  update_menu_right
    begin
      @object_type = params[:object_type]
      curriculum_study_id = params[:curriculum_id]
      user_id = session[:user_id]
      status = params[:status]
      status=status.to_i
      @curriculum_study_progress=CurriculumStudyProgress.get_curriculum_study_by_id(curriculum_study_id)
      #Update curriculum
      if @object_type == 'curriculum'
        if status == ProgressType::IN_PROGRESS
          @curriculum_study_progress.update_attributes(:actual_start_date => DateTime.now)
        end
        if status == ProgressType::DONE
          @curriculum_study_progress.update_attributes(:actual_end_date => DateTime.now)
          #Update all material
          materials=@curriculum_study_progress.material_study_progresses
          materials.each do |material|
            material.children.each do |child|
              if child.status == ProgressType::TO_DO
                child.update_attributes(:actual_start_date => DateTime.now)
                child.update_attributes(:actual_end_date => DateTime.now)
                child.update_attributes(:status => status)
              end
              if child.status == ProgressType::IN_PROGRESS
                child.update_attributes(:actual_end_date => DateTime.now)
                child.update_attributes(:status => status)
              end
            end
            if material.status == ProgressType::TO_DO
              material.update_attributes(:actual_start_date => DateTime.now)
              material.update_attributes(:actual_end_date => DateTime.now)
              material.update_attributes(:status => status)
            end
            if material.status == ProgressType::IN_PROGRESS
              material.update_attributes(:actual_end_date => DateTime.now)
              material.update_attributes(:status => status)
            end
          end
          #Update all action
          actions=@curriculum_study_progress.action_study_progresses
          actions.each do |action|
            if action.status == ProgressType::TO_DO
              action.update_attributes(:actual_start_date => DateTime.now)
              action.update_attributes(:actual_end_date => DateTime.now)
              action.update_attributes(:status => status)
            end
            if action.status == ProgressType::IN_PROGRESS
              action.update_attributes(:actual_end_date => DateTime.now)
              action.update_attributes(:status => status)
            end
          end
        end
        @curriculum_study_progress.update_attributes(:status => status)
        @object  = @curriculum_study_progress.curriculum
      #Update material
      elsif @object_type == 'material'
        material_study_id = params[:object_id]
        @material_study = MaterialStudyProgress.get_material_study_by_id(material_study_id)
        if status == ProgressType::IN_PROGRESS
          @material_study.update_attributes(:actual_start_date => DateTime.now)
          if @curriculum_study_progress.status == ProgressType::TO_DO
            @curriculum_study_progress.update_attributes(:status => status)
            @curriculum_study_progress.update_attributes(:actual_start_date => DateTime.now)
          end
          if @material_study.parent
            parent = @material_study.parent
            if parent.status == ProgressType::TO_DO
              parent.update_attributes(:status => status)
              parent.update_attributes(:actual_start_date => DateTime.now)
            end
          end
        end
        #Update status of material
        if status == ProgressType::DONE
          @material_study.update_attributes(:actual_end_date => DateTime.now)
          @material_study.children.each do |child|
            if child.status == ProgressType::TO_DO
              child.update_attributes(:actual_start_date => DateTime.now)
              child.update_attributes(:actual_end_date => DateTime.now)
              child.update_attributes(:status => status)
            end
            if child.status == ProgressType::IN_PROGRESS
              child.update_attributes(:actual_end_date => DateTime.now)
              child.update_attributes(:status => status)
            end
          end
        end
        @material_study.update_attributes(:status => status)
        @object  = @material_study.material
      #Update material
      elsif @object_type == 'action'
        @action_study=ActionStudyProgress.find_by(_id: params[:object_id])
        if status == ProgressType::IN_PROGRESS
          @action_study.update_attributes(:actual_start_date => DateTime.now)
          if @curriculum_study_progress.status == ProgressType::TO_DO
            @curriculum_study_progress.update_attributes(:actual_start_date => DateTime.now)
            @curriculum_study_progress.update_attributes(:status => status)
          end
        end
        if status == ProgressType::DONE
          @action_study.update_attributes(:actual_end_date => DateTime.now)
        end
        @action_study.update_attributes(:status => status)
        @object  =  @action_study.action
      end
      @material_study_progresses = MaterialStudyProgress.get_material_by_curriculum_study(curriculum_study_id)
      @total_material_done = 0
      @total_action_done = 0
      @material_study_progresses.each do |item|
        if item.status == ProgressType::DONE
          @total_material_done=@total_material_done + 1
        end
      end
      @action_study_progresses =ActionStudyProgress.where(curriculum_study_progress_id: @curriculum_study_progress._id).order_by(action_id: 1)
      @action_study_progresses.each do |item|
        if item.status == ProgressType::DONE
          @total_action_done = @total_action_done + 1
        end
      end
      @total_material = @material_study_progresses.size()
      @percentage_material = @total_material_done.to_f/@total_material*100
      @total_action = @action_study_progresses.size()
      @percentage_action = @total_action_done.to_f/@total_action*100
      if @total_action > 0
        @percentage_action = @total_action_done.to_f/@total_action*100
      else
        @percentage_action = 100
      end
      respond_to do |format|
        format.js
      end
    rescue Exception => e
      logger.error("notification save error: #{e.message}")
    end
  end
end
