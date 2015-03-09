# Class Name: UserProfile
# Description: UserProfile model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class UserProfile
  include Mongoid::Document

  #fields
  # field :title, type: Integer
  field :birthday, type: Date
  field :phone, type: String
  field :address, type: String
  field :city, type: String
  has_one :user_profile

  #relations
  belongs_to :user
end
