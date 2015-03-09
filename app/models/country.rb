# Class Name: UserProfile
# Description: UserProfile model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class Country
  include Mongoid::Document

  #fields
  field :name, type: String

  #relations
  belongs_to :user
end
