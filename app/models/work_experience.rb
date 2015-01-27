# Class Name: WorkExperience
# Description: work experience model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 18/12/2014
# Modify Date:

class WorkExperience
  include Mongoid::Document
  include Mongoid::Timestamps

  WORK_PLACE_MAX_LENGTH = 200
  DESCRIPTION_MAX_LENGTH = 200

  #fields
  field :work_place, type: String
  field :start_year, type: Integer
  field :end_year, type: Integer
  field :current, type: Boolean
  field :description, type: String

  #relations
  belongs_to :user
  belongs_to :category
  belongs_to :level

  #indexs
  index({user_id: 1})

  #validates
  validates_length_of :work_place, maximum: WORK_PLACE_MAX_LENGTH

  validates_presence_of :category, :level, :user
  validates_presence_of :start_year
  validates_numericality_of :start_year, only_integer: true, greater_than_or_equal_to: 1905, less_than_or_equal_to: Time.now.year
  validates_numericality_of :end_year, only_integer: true, greater_than_or_equal_to: 1905, less_than_or_equal_to: Time.now.year, allow_blank: true

  validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH

  validate :validate_years

  def validate_years
    # if !self.end_year.nil? && !self.start_year.nil? && self.end_year < self.start_year
    #   errors.add(:end_year, :greater_than_start_date, :count => 1)
    # end
    #

    #
    # if self.current && !self.end_year.nil? && self.end_year < Time.now.year
    #   errors.add(:end_year, :greater_than_or_equal_current_date, :count => 1)
    # end

    if self.current
      self.end_year = nil
    end

    #check start year
    # if !self.start_year.nil?
    #   if self.start_year < 1905
    #     errors.add(:start_year, :greater_than_or_equal_to, :count => 1905)
    #   end
    #
    #   if self.start_year > Time.now.year
    #     errors.add(:start_year, :less_than_or_equal_to, :count => Time.now.year)
    #   end
    # end
    #
    # #check end year
    # if !self.end_year.nil?
    #   if self.end_year < 1905
    #     errors.add(:end_year, :greater_than_or_equal_to, :count => 1905)
    #   end
    #
    #   if self.end_year > Time.now.year
    #     errors.add(:end_year, :less_than_or_equal_to, :count => Time.now.year)
    #   end
    # end


    if !self.start_year.nil? && !self.end_year.nil? && end_year < start_year
      errors.add(:end_year, :greater_than_or_equal_to, :count => self.start_year)
    end

  end
end

