# encoding: UTF-8
# Source Code Modifications (c) 2010 Laurence A. Lee, 
# See /RUBYJEDI.txt for Licensing and Distribution Terms
# Handles storing of preferences for the application.
#
# This is an internal structure mostly, which is useful to access / save
# things from the GUI.
#
# Prefs are used all over to handle decisions that we'd rather
# not use config files for.
#

class Preference < ActiveRecord::Base  
  # Types can hold strings, booleans, or pointers to
  # other records (like country)
  CC_PROCESSORS = ['Authorize.net', 'PayPal IPN']
  MAIL_AUTH = ['none', 'plain', 'login', 'cram_md5']
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Can throw an error if these items aren't set.
  # Make sure to wrap any block that calls this
  def self.init_mail_settings
    if Preference.get_value_is_true?('use_smtp_tls_patch')
      require "smtp_tls"
    else
      # Remove the Net::SMTP::Revision constant.
      Net::SMTP.class_eval do
        remove_const :Revision.to_s if const_defined? :Revision.to_s
      end
      # Remove the Net::SMTPSession constant.
      Net.class_eval do
        remove_const :SMTPSession.to_s if const_defined? :SMTPSession.to_s
      end
      # Remove the SMTP constant.
      Object.class_eval do
        remove_const :SMTP.to_s if const_defined? :SMTP.to_s
      end
      # Reload the net/smtp.rb class.
      require "net/smtp"
    end
    
    # SET MAIL SERVER SETTINGS FROM PREFERENCES
    mail_host = get_value('mail_host')
    mail_server_settings = {
      :address => mail_host,
      :domain => mail_host,
      :port => get_value('mail_port'),
    }
    mail_auth_type = get_value('mail_auth_type')
    if mail_auth_type != 'none'
      mail_server_settings[:authentication] = mail_auth_type.to_sym
      mail_server_settings[:user_name] = get_value('mail_username')
      mail_server_settings[:password] = get_value('mail_password')
    end
    ActionMailer::Base.smtp_settings = mail_server_settings
  end
  
  # Saves preferences passed in from our form.
  #
  def self.save_settings(settings)
    logger.info "SERVER SETTINGS..."
    logger.info settings.inspect
    settings.each do |name, value|
      update_all(["value = ?", value], ["name = ?", name])
    end
  end
  
  # Save a preference
  # like 'store_something' => true
  # LTODO it is a rails bug not accept symbols here? (it doesn't--only strings)
  def self.save_setting(hash)
    self.save_settings hash
  end
  
  # Safe way to get values for preferences.
  def self.get_value(key)
    pref = Preference.find_by_name(key)
    if pref
      return pref.value
    else
      return nil
    end
  end
  
  # Safe way to get true/false value of preference key.
  def self.get_value_is_true?(key)
    pref = Preference.find_by_name(key)
    if pref
      return pref.is_true?
    else
      return false
    end
  end
  
  # Determines if a preference is "true" or not.
  # This is the ghetto, bootleg way to determine booleans.
  def is_true?
    [true, "true", 1, "1", "T", "t"].include?(
      self.value.class == String ? self.value.downcase : self.value
    )
  end
end
