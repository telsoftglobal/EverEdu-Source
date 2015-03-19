# Class Name: User
# Description: User model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  # include Sunspot::Mongoid
  # include Mongoid::Search

  #constanst
  PASSWORD_MIN_LENGTH = 6
  NAME_MAX_LENGTH = 50
  EMAIL_MAX_LENGTH = 100
  ADDRESS_MAX_LENGTH = 100
  PHONE_NUMBER_MAX_LENGTH = 25
  INTRODUCTION_MAX_LENGTH = 2000
  #fields
  field :first_name, type: String
  field :last_name, type: String
  field :user_name, type: String
  field :email, type: String
  field :hashed_password, type: String
  field :salt, type: String
  field :status, type: Integer, default: 1
  field :avatar_url, type: String
  field :gender, type: Boolean
  field :birth_day, type: Date
  field :phone_number, type: String
  field :address, type: String
  field :city, type: String
  belongs_to :country
  field :introduction, type: String

  #attributes
  attr_accessor :password, :password_confirmation

  #validate
  validates_presence_of :first_name, :last_name, :user_name, :email
  validates_length_of :first_name, :last_name, :user_name, maximum: NAME_MAX_LENGTH
  validates_format_of :user_name, with:/\A[a-z0-9_\-\.]*\z/i
  validates_length_of :email, maximum: EMAIL_MAX_LENGTH
  validates_length_of :address,:city, maximum: ADDRESS_MAX_LENGTH
  validates_length_of :phone_number, maximum: PHONE_NUMBER_MAX_LENGTH
  validates_length_of :introduction, maximum: INTRODUCTION_MAX_LENGTH
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :validate_password_length, :validate_match_password
  validates_uniqueness_of :user_name, case_sensitive: false
  validates_uniqueness_of :email, case_sensitive: false

  #relations
  embeds_many :sns_accounts
  has_one :user_profile
  has_and_belongs_to_many :roles
  belongs_to  :avatar, :class_name => "Photo", :foreign_key => "avatar_id"
  embeds_many :specialties
  embeds_many :history_jobs
  embeds_many :educations

  #indexes
  index({ user_name: 1 }, { unique: true, name: 'user_name_index' })
  index({ email: 1 }, { unique: true, name: 'email_index' })

  accepts_nested_attributes_for :sns_accounts

  #before save callback
  before_save :update_hashed_password

  # search with Sunspot Solr
  # searchable do
  #   text :first_name, :last_name
  # end

  # search with mongoid_search
  # search_in :first_name, :last_name, :specialties => :special, :history_jobs => :title


  #validate password_confirmation is match with password
  def validate_match_password
    if password_confirmation && password != password_confirmation
      errors.add(:password, :confirmation)
    end
  end

  #validate password length
  def validate_password_length
    if !self.sns_accounts? || self.sns_accounts.size == 0
      if !password.nil? && password.size < PASSWORD_MIN_LENGTH
        errors.add(:password, :too_short, :count => PASSWORD_MIN_LENGTH)
      end

      if !password_confirmation.nil? && password_confirmation.size < PASSWORD_MIN_LENGTH
        errors.add(:password_confirmation, :too_short, :count => PASSWORD_MIN_LENGTH)
      end
    end
  end

  # update hashed_password if password was set
  def update_hashed_password
    if self.password
      self.salt = User.generate_salt
      self.hashed_password = User.encrypt_password(password, salt)
    end
  end

  def full_name
    first_name + ' ' + last_name
  end

  def specialty_info
    specialty_info = ''
    self.specialties.each do |s|
      specialty_info << s.specialty
      specialty_info << ', '
    end

    specialty_info = specialty_info.strip
    if !specialty_info.blank?
      specialty_info = specialty_info[0, specialty_info.length - 1]
    end

    specialty_info
  end

  def history_jobs_info
    history_jobs_info = ''
    self.history_jobs.each do |hj|
      history_jobs_info << hj.title
      history_jobs_info << ', '
    end

    history_jobs_info = history_jobs_info.strip
    if !history_jobs_info.blank?
      history_jobs_info = history_jobs_info[0, history_jobs_info.length - 1]
    end

    history_jobs_info
  end

  class << self
    # CuongCT Generate password
    def generate_password(length=6)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
      password = ''
      length.times { |i| password << chars[rand(chars.length)] }
      password
    end


    #this method generate salt to use in encrypt password
    def generate_salt
      Digest::SHA1.hexdigest([Time.now, rand].join)
    end

    # this method encrypt password with use SHA
    def encrypt_password(password, salt)
      Digest::SHA1.hexdigest([password, salt].join)
    end

    # this method process authentication with email and password
    def authenticate(email, password)
      if user = find_by_email(email)
        if !user.nil?
          if user.hashed_password == encrypt_password(password, user.salt)
            user
          end
        end
      end
    end

    #store current user
    # def current=(user)
    #   RequestStore.store[:current_user] = user
    # end
    #
    # def current
    #   RequestStore.store[:current_user] ||= nil
    # end

    # Description: find by email case insensitive
    # @param: email
    # @return: user
    # @throws Exception
    # @author HuyenDT
    # Create Date: 2014/12/11
    # Modify Date:
    def find_by_email(email)
      User.find_by(email: /^#{email}$/i)
    end

    # Description: find by user name case insensitive
    # @param: username
    # @return: user
    # @throws Exception
    # @author HuyenDT
    # Create Date: 2014/12/11
    # Modify Date:
    def find_by_username(user_name)
      User.find_by(user_name: /^#{user_name}$/i)
    end

    def process_when_update(user)

    end

    # Description: search mentor
    # @param: keyword, page_number, item_per_page
    # @return: users
    # @throws Exception
    # @author HuyenDT
    # Create Date: 20150317
    # Modify Date:
    def search_mentor(keyword, page_number, item_per_page)
      # select mentor role
      mentor_role = Role.find_by(name: Role::ROLE_DEFAULT)

      # query users
      @users = User.where(role_ids: mentor_role.id).and(status: 1).any_of({user_name: /#{keyword}/i}, {first_name: /#{keyword}/i}, {last_name: /#{keyword}/i}, {"specialties.specialty" => /#{keyword}/i}, {"history_jobs.title" => /#{keyword}/i}).paginate(:page => page_number, :per_page => item_per_page)

      @users
    end

    # Description: search mentor advance
    # @param: first_name, last_name, location, specialties, history_jobs, page_number, item_per_page
    # @return: users
    # @throws Exception
    # @author HuyenDT
    # Create Date: 20150317
    # Modify Date:
    def search_mentor_advance(first_name, last_name, location, specialties, history_jobs, page_number, item_per_page)
      # select mentor role
      mentor_role = Role.find_by(name: Role::ROLE_DEFAULT)

      # default query role mentor and status = 1
      query = User.where(role_ids: mentor_role.id).and(status: 1)

      # first name
      if !first_name.blank?
        query = query.and(first_name: /#{first_name}/i)
      end

      # last name
      if !last_name.blank?
        query = query.and(last_name: /#{last_name}/i)
      end

      # location
      if !location.blank?
        query = query.and(contry: location)
      end

      # specialties
      if !specialties.nil? && !specialties.empty?
        specialties = specialties.map{|s|/^#{s.strip}$/i}
        query = query.and("specialties.specialty" => { "$in" => specialties})
      end

      # history jobs
      if !history_jobs.nil? && !history_jobs.empty?
        history_jobs = history_jobs.map{|s|/^#{s.strip}$/i}
        query = query.and("history_jobs.title" => { "$in" => history_jobs})
      end

      # paginate
      @users = query.paginate(:page => page_number, :per_page => item_per_page)

      # return result
      @users
    end

  end

  #this method check user has a role
  def has_role?(role_name)
    has_role = false
    if !self.roles.nil?
      self.roles.each do |role|
        if role.name.eql?role_name
          has_role = true
        end
      end
    end

    has_role
  end

  #this method check user is mentor
  def is_mentor?
    has_role?(Role::ROLE_MENTOR)
  end

  #this method check user is student
  def is_student?
    has_role?(Role::ROLE_STUDENT)
  end

  #this method check user is admin
  def is_admin?
    has_role?(Role::ROLE_ADMIN)
  end

  # set update time before save, create, update
  def set_updated_time
    self.updated_at = Time.now
    if new_record?
      self.created_at = self.updated_at
    end
  end

  def count_unread_notification(activity_type, object_id, object_type)
    Notification.where(activity_type: activity_type, object_id: object_id, object_type: object_type, unread: TRUE, recipient_id: id).count()
  end

  def read_all_notification(activity_type, object_id, object_type)
    notifications = Notification.where(activity_type: activity_type, object_id: object_id, object_type: object_type, unread: TRUE, recipient_id: id)
    notifications.update_all(:unread => false)
  end



end
