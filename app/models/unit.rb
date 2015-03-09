# Class Name: Unit
# Description: Unit model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 06/11/2014
# Modify Date: 06/11/2014

class Unit
  include Mongoid::Document

  #fields
  field :unit_name, type: String
  field :show_priority, type: Integer, default: 1

  #validates
  validates_presence_of :unit_name, :show_priority
  validates_uniqueness_of :unit_name
end
