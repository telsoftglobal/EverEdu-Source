# Class Name: SnsAccount
# Description: SnsAccount model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class SnsAccount
  include Mongoid::Document

  #fields
  field :provider, type: String
  field :uid, type: String
  field :user_name, type: String
  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :image_url, type: String
  field :access_token, type: String
  field :access_token_secret, type: String
  field :created_at, type: Time, default: Time.now
  field :updated_at, type: Time, default: Time.now

  #relations
  embedded_in :user

  #before save callback
  before_save :set_updated_time

  #before update callback
  before_update :set_updated_time

  # set update time before save, create, update
  def set_updated_time
    self.updated_at = Time.now
    if new_record?
      self.created_at = self.updated_at
    end
  end

end
