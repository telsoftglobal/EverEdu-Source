# Class Name: Education
# Description: educations model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 23/12/2014
# Modify Date:

class Education
  include Mongoid::Document
  include Mongoid::Timestamps

  SCHOOL_NAME_MAX_LENGTH = 200
  DESCRIPTION_MAX_LENGTH = 200

  field :school_name, type: String
  field :start_year, type: Integer
  field :end_year, type: Integer
  field :current, type: Boolean
  field :description, type: String

  #relations
  # belongs_to :field, class_name: 'Category', foreign_key: :field_id
  belongs_to :user

  #indexs
  index({user_id: 1})

  #validates
  validates_presence_of :user
  validates_presence_of :school_name
  validates_length_of :school_name, maximum: SCHOOL_NAME_MAX_LENGTH
  validates_presence_of :start_year
  validates_numericality_of :start_year, only_integer: true, greater_than_or_equal_to: 1905, less_than_or_equal_to: Time.now.year
  validates_numericality_of :end_year, only_integer: true, greater_than_or_equal_to: 1905, less_than_or_equal_to: Time.now.year, allow_blank: true
  validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH

  validate :validate_years

  def validate_years
    if self.current
      self.end_year = nil
    end

    if !self.start_year.nil? && !self.end_year.nil? && end_year < start_year
      errors.add(:end_year, :greater_than_or_equal_to, :count => self.start_year)
    end
  end
end

