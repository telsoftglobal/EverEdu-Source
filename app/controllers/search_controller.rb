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
end
