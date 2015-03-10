# Class Name: UserProfile
# Description: UserProfile model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class UserProfile
  include Mongoid::Document

  #relations
  belongs_to :user
end
