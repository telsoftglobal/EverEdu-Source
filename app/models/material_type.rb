# Class Name: MaterialType
# Description: MaterialType model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 06/11/2014
# Modify Date: 06/11/2014

class MaterialType
  include Mongoid::Document
  #fields
  field :material_type_name, type: String
  field :show_priority, type: Integer, default: 1

  #validates
  validates_presence_of :material_type_name, :show_priority
  validates_uniqueness_of :material_type_name

end
