class SearchController < ApplicationController
  layout 'default'

  before_action :authenticate

  ITEM_PER_PAGE = 10

  def index

  end

  # Description: This method processes search curriculum with category and level
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  def search_curriculum
    #get category and level
    @categories = Category.get_all_categories
    @levels = Level.where(category_id: params[:category_id]).order_by(level_order: 1)

    #get parameters
    category_id = params[:category_id]
    level_id = params[:level_id]
    keyword = params[:keyword]
    if !keyword.nil?
      keyword = keyword.to_s
      keyword = keyword.strip
      keyword = normalize_special_characters(keyword)
    end

    page_number = params[:page]

    if category_id.blank?
      #flash.now[:error] = I18n.t('search_curriculum.msg_category_required')
    else
      #call method search in Curriculum model
      @curriculums = Curriculum.search(category_id, level_id, keyword, page_number, ITEM_PER_PAGE)
    end
  end


  # Description: This method processes search mentor
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  def search_mentor
    begin
      page_number = params[:page]
      keyword = params[:keyword]
      if !keyword.nil?
        keyword = keyword.to_s
        keyword = keyword.strip
        keyword = normalize_special_characters(keyword)
      end

      if keyword.blank?
      else
        @users = User.search_mentor(keyword, page_number, ITEM_PER_PAGE)
        @total_entries = @users.total_entries
      end
    rescue Exception => e
      logger.error("search mentor error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('search_mentor.msg_error')
        format.js { render action: 'search_error' }
        format.html
      end
    end
  end

  # Description: This method processes search mentor advance
  # @param
  # @return
  # @throws Exception
  # @author HuyenDT
  def search_mentor_advance
    begin
      # get params
      page_number = params[:page]
      first_name = normalize_string(params[:first_name])
      last_name = normalize_string(params[:last_name])
      location = normalize_string(params[:location])

      # normalize_special_characters
      first_name = normalize_special_characters(first_name)
      last_name = normalize_special_characters(last_name)
      specialties = Array.new
      if !params[:specialties].nil?
        params[:specialties].each do |specialty|
          specialties << normalize_special_characters(normalize_string(specialty))
        end
      end

      history_jobs = Array.new
      if !params[:history_jobs].nil?
        params[:history_jobs].each do |job|
          history_jobs << normalize_special_characters(normalize_string(job))
        end
      end

      # process searching
      @users = User.search_mentor_advance(first_name, last_name, location, specialties, history_jobs, page_number, ITEM_PER_PAGE)
      @total_entries = @users.total_entries
    rescue Exception => e
      logger.error("search mentor error: #{e.message}")
      respond_to do |format|
        flash.now[:error] = t('search_mentor.msg_error')
        format.js { render action: 'search_error' }
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

  def normalize_special_characters(string)
    pattern = /(\'|\"|\.|\*|\/|\-|\\|\&|\(|\)|\^|\%|\$|\#|\>|\<|\?|\{|\}|\[|\]|\~|\+)/
    string = string.gsub(pattern){|match|"\\"  + match}
    string
  end

  def normalize_string(string)
    normalize_string = string
    if string.nil?
      normalize_string = ''
    end

    normalize_string.squish
  end
end
