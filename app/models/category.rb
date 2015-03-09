# Class Name: Category
# Description: Category model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 06/11/2014
# Modify Date: 10/11/2014

class Category
  include Mongoid::Document
  include Mongoid::Tree

  #fields
  field :category_name, type: String
  field :status, type: Integer, default: 1
  field :show_priority, type: Integer, default: 1
  field :icon, type: String, default: ''

  #array store id of ancestor
  #field :ancestors, type: Array, default: []

  #relations
  #belongs_to :parent, class_name: self.name
  has_many :levels

  #validates
  validates_presence_of :category_name, :status, :show_priority
  validates_uniqueness_of :category_name

  #indexes
  index({ category_name: 1 }, { unique: true })

  class << self
    #get all categories with status is active and order by show_priority and category_name
    def get_all_categories
      categories = Category.where(status: 1).asc(:show_priority, :category_name)

      #create results array store categories
      results = Array.new
      categories.each do |category|
        if category.parent_ids && category.parent_ids.size > 0
          prefix = ''
          category.parent_ids.size.times do
            prefix = prefix + '&nbsp;&nbsp;&nbsp;'
          end
          category.category_name = (prefix + category.category_name).html_safe
        end
        results << category
      end
      results
    end

    #get childs of a category with category_id
    def get_childs_of_category(category_id)
      #convert string to BSON::ObjectId
      if !category_id.is_a?(BSON::ObjectId)
        category_id = BSON::ObjectId.from_string(category_id)
      end

      #find categories with ancestors have this category_id
      childs = Category.any_in(parent_ids: [category_id])

      results = Array.new
      childs.each do |child|
        results << child
      end

      results
    end
  end

  # get childs of this category
  def get_childs
    childs = Category.any_in(parent_ids: [parent.id])

    results = Array.new
    childs.each do |child|
      results << child
    end

    results
  end

end