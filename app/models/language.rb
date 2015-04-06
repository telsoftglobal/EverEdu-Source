# Class Name: Language
# Description: Language model class
# Version: 1.0
# Copyright: Telsoft
# Author: CuongCT
# Create Date: 01/04/2015
# Modify Date: 01/04/2015
class Language
  include Mongoid::Document
  #Const
  LANGUAGE_DEFAULT = 'ja'
  LANGUAGE_JAPAN = 'ja'
  LANGUAGE_ENGLISH = 'en'
  LANGUAGE_VIETNAM = 'vi'

  #fields
  field :id, type: String
  field :name, type: String
  #indexes
  index({ id: 1 }, { unique: true })
end