# encoding: UTF-8
# Source Code Modifications (c) 2010 Laurence A. Lee, 
# See /RUBYJEDI.txt for Licensing and Distribution Terms
class OrdersMailer < ActionMailer::Base
  helper :application

  def receipt(order, email_text)
    @subject = "Thank you for your order! (\##{order.order_number})"
    @order = order
    @email_text = email_text
    @recipients = order.order_user.email_address
    setup_defaults
  end

  def reset_password(customer)
    @subject = "Password reset for #{Preference.find_by_name('store_name').value}"
    @customer = customer
    @recipients = customer.email_address
    setup_defaults
  end

  def failed(order)
    @subject = "An order has failed on the site"
    @order = order
    @recipients = Preference.find_by_name('mail_copy_to').value.split(',')
    setup_defaults    
  end
  
  def testing array_to
    @subject = "Test from #{Preference.find_by_name('store_name').value}"
    #@body       = {:order => order}
    @recipients = array_to
    setup_defaults
    # we get here
  end
  
  private
  def setup_defaults
  
    Preference.find_by_name('mail_username').value
    @bcc        = Preference.find_by_name('mail_copy_to').value.split(',')
    @from       = Preference.find_by_name('mail_username').value
    @sent_on    = Time.now
    @headers    = {}
  end
  
end