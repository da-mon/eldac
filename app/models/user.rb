
require 'bcrypt'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || 'is not valid')
    end
  end
end

class User < ActiveRecord::Base

  include BCrypt

  validates :email, presence: true, uniqueness: true, email: true, length: {maximum: 64}
  validates :fname, presence: true, length: {in: 1..32}
  validates :lname, presence: true, length: {in: 1..32}
  validates :password, confirmation: true, presence: true, length: {in: 6..16}, :if => :pass_req?
  validates :password_confirmation, presence: true, :if => :pass_req?
  validates :p_salt, length: {maximum: 80}
  validates :p_hash, length: {maximum: 80}

  before_save :downcase_email

  def fullname
    "#{self.fname} #{self.lname}"
  end

  def self.authenticate(email, password)
    @user = User.where(:email => email).first
    return nil if @user.nil?
    return nil unless @user.email_valid
    if User.hash_password(password, @user.p_salt) == @user.p_hash
      @user.update_attribute('last_login', Time.current)
      return @user
    end
    nil
  end

  def password
    @password
  end

  def password=(passwd)
    @password = passwd
    return if passwd.blank?
    self.p_salt = User.salt
    self.p_hash = User.hash_password(@password, self.p_salt)
  end

  private

  def pass_req?
    self.p_hash.blank? || self.password
  end

  def downcase_email
    self.email = self.email.downcase
  end

  def self.salt
    BCrypt::Engine.generate_salt
  end

  def self.hash_password(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

end
