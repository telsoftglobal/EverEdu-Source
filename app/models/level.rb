# Class Name: Level
# Description: Level model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 13/11/2014
# Modify Date: 13/11/2014

class Level
  include Mongoid::Document

  #fields
  field :level_name, type: String
  field :description, type: String
  field :level_order, type: Integer
  field :xaxis, type: Integer
  field :yaxis, type: Integer

  #reletions
  belongs_to :category

  #indexes
  index({category_id: 1})
  index({level_name: 1})
end
