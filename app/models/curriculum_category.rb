# Class Name: CurriculumCategory
# Description: CurriculumCategory model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 13/11/2014
# Modify Date: 13/11/2014

class CurriculumCategory
  include Mongoid::Document

  #fields
  field :category_name, type: String

  #relations
  belongs_to :category
  has_and_belongs_to_many :levels

  embedded_in :curriculum
end
